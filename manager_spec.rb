require "manager"
require "user"

describe Manager do  
  before(:each) do
    @manager = Manager.new("manager", "manager99")
  end
  
  it "should be able to add clients balance" do
    @manager.should respond_to :add_clients_balance
  end
  
  it "should be able to set clients max debt" do
    @manager.should respond_to :set_clients_max_debt
  end
end