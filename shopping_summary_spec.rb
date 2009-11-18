require "shopping_summary"
require "matchers"

describe ShoppingSummary do
  before(:each) do
    @summary = ShoppingSummary.new
  end

  it "should have an average evaluation" do
    @summary.should respond_to :average_evaluation
  end

  it "should have a report list" do
    @summary.should respond_to :reports
    @summary.reports.should be_instance_of(Array)
  end
  
  it "should NOT be able to change average evaluation" do
    @summary.should_not respond_to(:average_evaluation=)
  end

end