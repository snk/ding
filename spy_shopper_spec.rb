require "spy_shopper"
require "shopping_report"
require "matchers"

describe SpyShopper do
  before(:each) do
    @spy = SpyShopper.new("pirkejas-petras", "pass", 25, "Studentas")
  end

  it "should be able to access assigned tasks" do
    @spy.should respond_to(:tasks)
  end

  it "should be able to add the shopping report" do
    @spy.add_report(1, Date.parse("2009-10-28"), Date.parse("2009-10-28"), "Puikus aptarnavimas visomis prasmemis", 10)
    ShoppingReport.list[1][0].complete_date.should == Date.parse("2009-10-28")
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
  
  it "should be able to change age" do
    @spy.should respond_to(:age=)
  end
  
  it "should be able to change occupation" do
    @spy.should respond_to(:occupation=)
  end
  
  it "should NOT be able to change assigned tasks" do
    @spy.should_not respond_to(:tasks=)
  end  
  
  it "should be a kind of User" do
    @spy.should be_kind_of(User)
  end

end