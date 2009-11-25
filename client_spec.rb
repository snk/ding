require "client"

describe Client do  
  before(:each) do
    @client = Client.new("bosas", "boss22", "Swedbank lizingas", "Gelezinio vilko g. 18A")
  end
  
  it "should have a company name" do
    @client.should respond_to :company
    @client.company.should be_instance_of(String)
  end
  
  it "should have a company address" do
    @client.should respond_to :address
    @client.address.should be_instance_of(String)
  end
  
  it "should have a balance" do
    @client.should respond_to :balance
    @client.balance.should be_kind_of(Integer)
  end
  
  it "should have a balance log" do
    @client.should respond_to :balance_log
    @client.balance_log.should be_instance_of(Array)
  end
  
  it "should have a max allowed debt" do
    @client.should respond_to :max_debt
    @client.max_debt.should be_kind_of(Integer)
  end
  
  it "should have a service cost" do
    @client.should respond_to :service_cost
    @client.service_cost.should be_kind_of(Integer)
  end
  
  it "should be able to change company name" do
    @client.should respond_to(:company=)
  end
  
  it "should be able to change company address" do
    @client.should respond_to(:address=)
  end
  
  it "should be able to change max allowed debt" do
    @client.should respond_to(:max_debt=)
  end
  
  it "should be able to access spy shoppers list" do
    @client.should respond_to :spy_shoppers
    @client.spy_shoppers.should be_instance_of(Array)
  end
  
  it "should be able to check if balance is valid for adding task" do
    @client.should respond_to :balance_valid
    
    @client.add_balance(-26)
    @client.max_debt = 100
    @client.service_cost = 75
    @client.balance_valid.should be_false
    
    @client = Client.new("bosas", "boss22", "Swedbank lizingas", "Gelezinio vilko g. 18A")
    @client.add_balance(75)
    @client.max_debt = 0
    @client.service_cost = 75
    @client.balance_valid.should be_true
  end
  
  it "should be able to add task for spy shoppers" do
    @client.should respond_to :add_task
    @client.add_balance(-500)
    lambda { @client.add_task(nil, nil) }.should raise_error
    @client.balance_valid.should be_false
  end
  
  it "should NOT be able to change spy shoppers list" do
    @client.should_not respond_to(:spy_shoppers=)
  end
  
  it "should NOT be able to change balance" do
    @client.should_not respond_to(:balance=)
  end
  
  it "should NOT be able to change balance log" do
    @client.balance_log.should_not respond_to(:balance_log=)
  end
  
  it "should be a kind of User" do
    @client.should be_kind_of(User)
  end  

end