require "shopping_task"
require "matchers"
require "date"

describe ShoppingTask do
  before(:each) do  
    @client = Client.new("client", "pass", "company name", "company address")
    @spy = SpyShopper.new("spy", "pass", 22, "Programmer, IT company")
    @task = ShoppingTask.new(
      client: @client,
      spy: @spy,
      spy_date: DateTime.parse("2009-12-25 11:00:00"),
      description: "Aplankyti musu kavine per pirmaja kaledu diena",
      status: "P"
    )
  end
  
  it "should have a client who created this task" do
    @task.should respond_to :client
    @task.client.should be_instance_of(Client)
    @task.client.should_not be_nil
  end
  
  it "should have a spy who will do the task" do
    @task.should respond_to :spy
    @task.spy.should be_instance_of(SpyShopper)
    @task.spy.should_not be_nil
  end
  
  it "should have a expected execution date and time" do
    @task.should respond_to :spy_date
    @task.spy_date.should be_instance_of(DateTime)
  end
  
  it "should have a description" do
    @task.should respond_to :description
    @task.description.should be_instance_of(String)
  end
  
  it "should have a status [P]ending or [D]one" do
    @task.should respond_to :status
    @task.status.should be_instance_of(String)
    @task.status.should apply_symbols('P', 'D')
  end
  
  it "should have a report" do
    @task.should respond_to :report
  end
  
  it "should have a create date and time" do
    @task.should respond_to :created
    @task.created.should be_instance_of(DateTime)
  end
end


describe ShoppingTask, "as a tasks DB" do
  before(:each) do  
    @client = Client.new("client", "pass", "company name", "company address")
    @spy = SpyShopper.new("spy", "pass", 22, "Programmer, IT company")
    @task = ShoppingTask.new(
      client: @client,
      spy: @spy,
      spy_date: DateTime.parse("2009-12-25 11:00:00"),
      description: "Aplankyti musu kavine per pirmaja kaledu diena",
      status: "P"
    )
  end
  
  it "should be able to insert task" do
    ShoppingTask.should respond_to(:insert)
    ShoppingTask.insert(@task)
    ShoppingTask.tasks.should include(@task)
    
    lambda { ShoppingTask.insert(@task) }.should change(ShoppingTask.tasks, :length).by(1)
  end
  
  it "should be able to list tasks assigned by client" do
    ShoppingTask.should respond_to(:client)
    ShoppingTask.insert(@task)
    ShoppingTask.client(@client).should include(@task)
    
    @client_jonas = Client.new("jonas", "pass", "company", "address")
    @task = ShoppingTask.new(
      client: @client_jonas,
      spy: @spy,
      spy_date: DateTime.parse("2009-12-25 11:00:00"),
      description: "Aplankyti musu kavine per pirmaja kaledu diena",
      status: "P"
    )
    ShoppingTask.insert(@task)
    ShoppingTask.client(@client).should_not include(@task)
    ShoppingTask.client(@client_jonas).should include(@task)
  end
  
  it "should be able to list tasks assigned to spy" do
    ShoppingTask.should respond_to(:spy)
    ShoppingTask.insert(@task)
    ShoppingTask.spy(@spy).should include(@task)
    
    @spy_petras = SpyShopper.new("petras", "pass", 20, "Student, University")
    @task = ShoppingTask.new(
      client: @client,
      spy: @spy_petras,
      spy_date: DateTime.parse("2009-12-25 11:00:00"),
      description: "Aplankyti musu kavine per pirmaja kaledu diena",
      status: "P"
    )
    ShoppingTask.insert(@task)
    ShoppingTask.spy(@spy).should_not include(@task)
    ShoppingTask.spy(@spy_petras).should include(@task)
  end
  
  it "should be able to insert report" do
    ShoppingTask.should respond_to :insert_report
    @report = ShoppingReport.new(
      date_start: Date.parse("2009-11-25 12:15:00"),
      date_end: Date.parse("2009-11-25 13:15:00"),
      kindness: 8,
      knowledge: 9,
      service: 7,
      tidiness: 10,
      attitude: 5,
      activity: 4,
      selling: 6,
      politeness: 5
    )
    
    ShoppingTask.insert_report(@task, @report)
    ShoppingTask.client(@client)[0].report.should eql(@report)
  end  
end