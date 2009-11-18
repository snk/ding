require "shopping_report"
require "matchers"

describe ShoppingReport do
  before(:each) do
    @report = ShoppingReport.new(
            Date.parse("2009-10-15"),
            Date.parse("2009-10-27"),
            "Apsipirkimu likau nelabai patenkintas. Darbuotoja Z.B. elgesi nelabai mandagiai.",
            7
    )
  end

  it "should have a assign date" do
    @report.should respond_to :assign_date
    @report.assign_date.should be_instance_of(Date)
  end

  it "should have a complete date" do
    @report.should respond_to :complete_date
    @report.complete_date.should be_instance_of(Date)
  end

  it "should have a description" do
    @report.should respond_to :description
    @report.description.should be_instance_of(String)
  end

  it "should have a evaluation between 1 and 10" do
    @report.should respond_to :evaluation
    @report.evaluation.should be_instance_of(Fixnum)
    @report.evaluation.should apply_interval(1, 10)
  end
end