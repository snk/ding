require "user"

class SpyShopper < User
  
  attr_accessor :age, :occupation, :bonus_percent, :bonus_log
  
  def initialize(login, password, age, occupation)
    super(login, password)
    @age = age
    @occupation = occupation
    @bonus_percent = 0.05
    @bonus_log = []
  end

  def add_report(task_id, assign_date, complete_date, description, evaluation)
    #report = ShoppingReport.new(task_id, assign_date, complete_date, description, evaluation)
    #ShoppingReport.add(report)
  end
  
  def add_bonus(task)
    service_cost = task.client.service_cost
    count = service_cost * @bonus_percent
    bonus = { task: task, bonus_percent: @bonus_percent, service_cost: service_cost, bonus: count }
    bonus_log << bonus
  end

end
