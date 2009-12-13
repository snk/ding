require "manager"
require "user"

describe Manager do
  before(:each) do
    @manager = Manager.new("manager", "manager99")
  end
  
  it "should be able to add clients balance" do
    @manager.should respond_to :add_clients_balance
    @client = Client.new("klientas", "123", "Swedbank lizingas", "Gelezinio vilko g. 18A")
    User.insert(@client)
    @manager.add_clients_balance(@client, 700)
    User.clients["klientas"].balance.should eql(700)
  end
  
  it "should be able to set clients max debt" do
    @manager.should respond_to :set_clients_max_debt
    @client = Client.new("client", "123", "Swedbank lizingas", "Gelezinio vilko g. 18A")
    User.insert(@client)
    @manager.set_clients_max_debt(@client, 2000)
    User.clients["client"].max_debt.should eql(2000)
  end
end