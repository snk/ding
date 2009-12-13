require 'client'

describe Client do
  before(:each) do
    @client = Client.new("bosas", "boss22", "Swedbank lizingas", "Gelezinio vilko g. 18A")
    User.insert(@client)
    @client = User.db[@client.login]
  end

  after(:each) do
    User.db.delete("bosas")
  end

  it "should have a company name" do
    @client.should respond_to :company
    @client.company.should be_instance_of(String)
  end
  
  it "should have a company address" do
    @client.should respond_to :address
    @client.address.should be_instance_of(String)
  end
  
  it "should have a balance" do
    @client.should respond_to :balance
    @client.balance.should be_kind_of(Integer)
  end
  
  it "should have a balance log" do
    @client.should respond_to :balance_log
    @client.balance_log.should be_instance_of(Array)
  end
  
  it "should have a max allowed debt" do
    @client.should respond_to :max_debt
    @client.max_debt.should be_kind_of(Integer)
  end
  
  it "should have a service cost" do
    @client.should respond_to :service_cost
    @client.service_cost.should be_kind_of(Integer)
  end
  
  it "should have a max balance" do
    @client.should respond_to :max_balance
    @client.add_balance(300)
    @client.max_debt = 200
    @client.max_balance.should eql(500)
  end
  
  it "should be able to change company name" do
    @client.should respond_to(:company=)
  end
  
  it "should be able to change company address" do
    @client.should respond_to(:address=)
  end
  
  it "should be able to change max allowed debt" do
    @client.should respond_to(:max_debt=)
  end
  
  it "should be able to access spy shoppers list" do
    @client.should respond_to :spy_shoppers
    @client.spy_shoppers.should be_instance_of(Array)
  end
  
  it "should be able to check if balance is valid for adding task" do
    @client.should respond_to :balance_valid
    @client.add_balance(-26)
    @client.max_debt = 100
    @client.service_cost = 75
    @client.balance_valid.should be_false
    
    @client = Client.new("bosas", "boss22", "Swedbank lizingas", "Gelezinio vilko g. 18A")
    @client.add_balance(-200)
    @client.max_debt = 250
    @client.service_cost = 50
    @client.balance_valid.should be_true
  end

  it "should be able to add task for spy shoppers if balance is valid" do
    @client.should respond_to :add_task
    @client.add_balance(1000)    
    @spy = SpyShopper.new("spy", "pass", 22, "Programmer, IT company")
    @task = ShoppingTask.new(
      client: @client,
      spy: @spy,
      spy_date: DateTime.parse("2009-12-25 11:00:00"),
      description: "Aplankyti musu kavine per pirmaja kaledu diena",
      status: "P"
    )
    
    lambda { @client.add_task(@task) }.should_not raise_error
    @client.balance_valid.should be_true
  end
  
  it "should NOT be able to add task for spy shoppers if balance is not valid" do
    @client.should respond_to :add_task
    @client.add_balance(-500)
    @spy = SpyShopper.new("spy", "pass", 22, "Programmer, IT company")
    @task = ShoppingTask.new(
      client: @client,
      spy: @spy,
      spy_date: DateTime.parse("2009-12-25 11:00:00"),
      description: "Aplankyti musu kavine per pirmaja kaledu diena",
      status: "P"
    )    
    lambda { @client.add_task(@task) }.should raise_error
    @client.balance_valid.should be_false
  end
  
  it "should be able to access assigned tasks" do
    task = "Aplankyti musu parduotuve piko metu savaitgali, tarp 14 ir 16 valandos."
    @client.should respond_to :assigned_tasks
    @client.add_balance(500)
    spy = SpyShopper.new("mykolas", "111", "Student", "20")
    User.insert(spy)
  end
  
  it "should be able to check if real balance is valid" do
    @client.should respond_to :real_balance_valid
    @client.add_balance(500)
    @client.real_balance_valid.should be_true
    @client.add_balance(-1000)
    @client.real_balance_valid.should be_false
  end
  
  it "should be able to list positive balance" do
    @client.should respond_to :balance_log_positive
    @client.add_balance(500)
    @client.balance_log_positive.should be_instance_of(Array)
    @client.balance_log_positive[0][:amount].should eql(500)
  end
  
  it "should be able to list negative balance" do
    @client.should respond_to :balance_log_negative
    @client.add_balance(-500)
    @client.balance_log_negative.should be_instance_of(Array)
    @client.balance_log_negative[0][:amount].should eql(-500)
  end  
  
  it "should NOT be able to change spy shoppers list" do
    @client.should_not respond_to(:spy_shoppers=)
  end
  
  it "should NOT be able to change balance" do
    @client.should_not respond_to(:balance=)
  end
  
  it "should NOT be able to change balance log" do
    @client.balance_log.should_not respond_to(:balance_log=)
  end
  
  it "should be a kind of User" do
    @client.should be_kind_of(User)
  end  

end