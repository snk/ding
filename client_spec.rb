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

  it "should be able to access spy shoppers list" do
    @client.should respond_to :spy_shoppers
  end
  
  it "should be a kind of User" do
    @client.should be_kind_of(User)
  end  

end