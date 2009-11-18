class ShoppingReport
  def initialize(order_id, assign_date, complete_date, description, evaluation)
    @order_id = order_id
    @assign_date = assign_date
    @complete_date = complete_date
    @description = description
    @evaluation = evaluation
  end
  
  attr_reader :order_id, :assign_date, :complete_date
  attr :description, true
  attr :evaluation, true


  @list = {}
  class << self
    attr :list, true
  end

  def ShoppingReport.add(report)
    if !@list.keys.include? report.order_id
      @list[report.order_id] = [report];
    else
      @list[report.order_id].push(report)
    end
  end
end