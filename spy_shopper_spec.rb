require "spy_shopper"
require "shopping_report"

describe SpyShopper do
  before(:each) do
    @spy = SpyShopper.new("pirkejas-petras", "111222333")
  end

  it "should be able to access assigned orders" do
    @spy.should respond_to(:orders)
  end

  it "should be able to add the shopping report" do
    @spy.add_report(1, Date.parse("2009-10-28"), Date.parse("2009-10-28"), "Puikus aptarnavimas visomis prasmemis", 10)
    ShoppingReport.list[1][0].complete_date.should == Date.parse("2009-10-28")
  end

end