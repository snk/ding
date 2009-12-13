require "spy_shopper"
require "shopping_report"
require "matchers"

describe SpyShopper do
  before(:each) do
    @spy = SpyShopper.new("pirkejas-petras", "pass", 25, "Studentas")
  end

  it "should be able to add the shopping report" do
    @spy.add_report(1, Date.parse("2009-10-28"), Date.parse("2009-10-28"), "Puikus aptarnavimas visomis prasmemis", 10)
    #ShoppingReport.list[1][0].complete_date.should == Date.parse("2009-10-28")
  end
  
  it "should have an age between 18 and 50" do
    @spy.should respond_to(:age)
    @spy.age.should be_instance_of(Fixnum)
    @spy.age.should apply_interval(18, 50)
  end
  
  it "should have an occupation" do
    @spy.should respond_to(:occupation)
    @spy.occupation.should be_instance_of(String)
  end
  
  it "should have a bonus percent" do
    @spy.should respond_to(:bonus_percent)
    @spy.bonus_percent.should be_instance_of(Float)
  end
  
  it "should have a bonus log" do
    @spy.should respond_to(:bonus_log)
    @spy.bonus_log.should be_instance_of(Array)
    @spy.bonus_log.should_not be_nil
  end
  
  it "should have a schedule" do
    @spy.should respond_to(:schedule)
    @spy.schedule.should be_instance_of(SpySchedule)
    @spy.schedule.should_not be_nil
  end
  
  it "should be able to add bonus to bonus log" do
    @spy.should respond_to(:add_bonus)
    @client = Client.new("client", "pass", "company name", "company address")
    @spy = SpyShopper.new("spy", "pass", 22, "Programmer, IT company")
    @task = ShoppingTask.new(
      client: @client,
      spy: @spy,
      spy_date: DateTime.parse("2009-12-25 11:00:00"),
      description: "Aplankyti musu kavine per pirmaja kaledu diena",
      status: "P"
    )
    @spy.add_bonus(@task)
    @spy.bonus_log[0][:bonus].should eql(4.5)
  end
  
  it "should be able to change age" do
    @spy.should respond_to(:age=)
  end
  
  it "should be able to change occupation" do
    @spy.should respond_to(:occupation=)
  end
  
  it "should be able to change bonus percent" do
    @spy.should respond_to(:bonus_percent=)
  end
  
  it "should be a kind of User" do
    @spy.should be_kind_of(User)
  end

end