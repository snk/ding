require "user"

class SpyShopper < User
  def initialize(login, password, age, occupation)
    super(login, password)
    @age = age
    @occupation = occupation
    @tasks = []
  end

  def add_report(task_id, assign_date, complete_date, description, evaluation)
    report = ShoppingReport.new(task_id, assign_date, complete_date, description, evaluation)
    ShoppingReport.add(report)  
  end

  attr :tasks 
  attr :age, true
  attr :occupation, true
end
