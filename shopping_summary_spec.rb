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
end