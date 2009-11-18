class ShoppingReport
  def initialize(assign_date, complete_date, description, evaluation)
    @assign_date = assign_date
    @complete_date = complete_date
    @description = description
    @evaluation = evaluation
  end
  
  attr_reader :assign_date, :complete_date, :description, :evaluation
end