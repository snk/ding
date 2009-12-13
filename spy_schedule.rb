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
  
  def current
    list = []
    now = Time.now
    current_week = now.strftime("%W").to_i
    next_week = current_week + 1
    @schedule.each_pair do |key, time|
      c_week_key = now.year.to_s + "-" + current_week.to_s
      n_week_key = now.year.to_s + "-" + next_week.to_s
      if key[0..6] == c_week_key then
        list << {:date => key, :time => time, :week => 'current'}
      elsif key[0..6] == n_week_key then
        list << {:date => key, :time => time, :week => 'next'}
      end
    end
    list
  end

end
