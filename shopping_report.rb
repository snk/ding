class ShoppingReport
  def initialize(task_id, assign_date, complete_date, description, evaluation)
    @task_id = task_id
    @assign_date = assign_date
    @complete_date = complete_date
    @description = description
    @evaluation = evaluation
  end
  
  attr_reader :task_id, :assign_date, :complete_date
  attr :description, true
  attr :evaluation, true


  @list = {}
  class << self
    attr :list, true
  end

  def ShoppingReport.add(report)
    if !@list.keys.include? report.task_id
      @list[report.task_id] = [report];
    else
      @list[report.task_id].push(report)
    end
  end
end