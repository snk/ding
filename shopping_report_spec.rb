require "shopping_report"
require "matchers"
require "date"

describe ShoppingReport do
  before(:each) do
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
  end
  
  it "should have a start date" do
    @report.should respond_to :date_start
    @report.date_start.should be_instance_of(Date)
  end
  
  it "should have a end date" do
    @report.should respond_to :date_end
    @report.date_end.should be_instance_of(Date)
  end
  
  it "should have a kindness evaluation between 1 and 10 or 0 if undefined" do
    @report.should respond_to :kindness
    @report.kindness.should be_instance_of(Fixnum)
    @report.kindness.should apply_interval(0, 10)
  end
  
  it "should have a knowledge evaluation between 1 and 10 or 0 if undefined" do
    @report.should respond_to :knowledge
    @report.knowledge.should be_instance_of(Fixnum)
    @report.knowledge.should apply_interval(0, 10)
  end

  it "should have a service evaluation between 1 and 10 or 0 if undefined" do
    @report.should respond_to :service
    @report.service.should be_instance_of(Fixnum)
    @report.service.should apply_interval(0, 10)
  end

  it "should have a tidiness evaluation between 1 and 10 or 0 if undefined" do
    @report.should respond_to :tidiness
    @report.tidiness.should be_instance_of(Fixnum)
    @report.tidiness.should apply_interval(0, 10)
  end

  it "should have a attitude evaluation between 1 and 10 or 0 if undefined" do
    @report.should respond_to :attitude
    @report.attitude.should be_instance_of(Fixnum)
    @report.attitude.should apply_interval(0, 10)
  end
  
  it "should have a activity evaluation between 1 and 10 or 0 if undefined" do
    @report.should respond_to :activity
    @report.activity.should be_instance_of(Fixnum)
    @report.activity.should apply_interval(0, 10)
  end
  
  it "should have a selling evaluation between 1 and 10 or 0 if undefined" do
    @report.should respond_to :selling
    @report.selling.should be_instance_of(Fixnum)
    @report.selling.should apply_interval(0, 10)
  end

  it "should have a politeness evaluation between 1 and 10 or 0 if undefined" do
    @report.should respond_to :politeness
    @report.politeness.should be_instance_of(Fixnum)
    @report.politeness.should apply_interval(0, 10)
  end

end