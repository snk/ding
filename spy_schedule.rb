require "date"

class SpySchedule
  
  attr_accessor :schedule
  
  def initialize()
    @schedule = {}
    
    #saugoma pagal ['year-week-day'] = array
    #ir metodai ten add/delete
  end
  
  def add(year, week, day, interval_start, interval_end)
    key = year.to_s + "-" + week.to_s + "-" + day.to_s
    val = interval_start + "-" + interval_end
    @schedule[key] = val
  end

end
