require "user"
require "matchers"

describe User do
  before(:each) do
    @user = User.new("Person", "123")
  end

  it "should have a login" do
    @user.should respond_to(:login)
    @user.login.should be_instance_of(String)
  end

  it "should have a MD5 encoded password" do
    @user.should respond_to(:password)
    @user.password.should be_MD5
  end
  
  it "should have status" do
    @user.should respond_to(:status)
  end
  
  it "should be able to check if it is a SpyShopper" do
    @user.should respond_to(:is_spy_shopper)
    @spy = SpyShopper.new("pirkejas-petras", "pass", 25, "Studentas")
    @spy.is_spy_shopper.should be_true
  end
  
  it "should be able to check if it is a Client" do
    @user.should respond_to(:is_client)
    @client = Client.new("bosas", "boss22", "Swedbank lizingas", "Gelezinio vilko g. 18A")
    @client.is_client.should be_true
  end
  
  it "should be able to check if it is a Manager" do
    @user.should respond_to(:is_manager)
    @manager = Manager.new("manager", "manager99")
    @manager.is_manager.should be_true
  end
end


describe User, "as a users DB" do
  before(:each) do
    @user = User.new("Person", "123")
  end
  
  it "should be able to insert user" do
    User.should respond_to(:insert)
    User.insert(@user)
    User.db.keys.should include("Person")
    User.db["Person"].should == @user
  end
  
  it "should NOT be able to insert users with same login" do
    lambda { User.insert(@user) }.should raise_error
  end
  
  it "should be able to check if user exists" do
    User.should respond_to(:exists)
    User.exists(@user.login).should be_true
    User.exists("some-bad-login").should be_false
  end
  
  it "should be able to find user by id" do
    u = User.new("Man", "111")
    User.insert(u)
    id = User.db[u.login].id
    User.db[u.login].should eql(User.by_id(id))
  end
  
  it "should be able to validate login and password" do
    User.should respond_to(:valid)
    User.valid("Person", "123").should be_true
    User.valid("Person", "999").should be_false
  end
  
  it "should be able to get list of SpyShoppers" do
    User.should respond_to(:spy_shoppers)
    @spy = SpyShopper.new("pirkejas-petras", "pass", 25, "Studentas")
    User.insert(@spy)
    User.spy_shoppers.values.should include(@spy)
  end
  
  it "should be able to get list of Clients" do
    User.should respond_to(:clients)
    @client = Client.new("bosas", "boss22", "Swedbank lizingas", "Gelezinio vilko g. 18A")
    User.insert(@client)
    User.clients.values.should include(@client)
  end
end  