#!/usr/bin/env ruby

require "date"
require "shopping_report"

@reports = {}
if !@reports.keys.include? "3"
  @reports["3"] = ["aa"]
else
  @reports["3"].push("bb")
end

if !@reports.keys.include? "3"
  @reports["3"].push("bb")
else
  @reports["3"].push("bb")
end

#puts @reports.values


@report = ShoppingReport.new(
        1,
        Date.parse("2009-10-15"),
        Date.parse("2009-10-27"),
        "Apsipirkimu likau nelabai patenkintas. Darbuotoja Z.B. elgesi nelabai mandagiai.",
        7
)
ShoppingReport.add(@report)


@balance_log = []
@balance_log.push({"time" => Time.now.strftime("%Y-%m-%d %H:%M:%S"), "amount" => 200})

#puts @balance_log.inspect
puts @balance_log[0]["time"]

puts "stras".size