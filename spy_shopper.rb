require "user"

class SpyShopper < User
  def initialize(username, password)
    super(username, password)
    @orders = {}
  end

  def add_report(order_id, assign_date, complete_date, description, evaluation)
    report = ShoppingReport.new(order_id, assign_date, complete_date, description, evaluation)
    ShoppingReport.add(report)  
  end

  attr :orders
end
