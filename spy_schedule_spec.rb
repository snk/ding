require "spy_schedule"
require "matchers"

describe SpySchedule do
  before(:each) do
    @schedule = SpySchedule.new
  end
  
  it "should be able to add year-week-day interval" do
    @schedule.should respond_to :add
    lambda { @schedule.add(2009, 50, 1, "10:15", "12:15") }.should change(@schedule.schedule, :size).by(1)
    @schedule.schedule.should include("2009-50-1")
  end

end