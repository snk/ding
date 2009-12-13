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
  
  it "should be able to list schedule of this week and next week" do
    @schedule.should respond_to :current
    now = Time.now
    current_week = now.strftime("%W").to_i
    old_week = current_week - 1
    next_week = current_week + 1
    
    lambda { @schedule.add(now.year, old_week, 1, "08:00", "20:00") }.should_not change(@schedule.current, :length).by(1)
    @schedule.current.length.should eql(0)
    @schedule.add(now.year, current_week, 1, "12:00", "14:00")
    @schedule.current.length.should eql(1)
    @schedule.add(now.year, next_week, 1, "18:00", "20:00")
    @schedule.current.length.should eql(2)
  end

end