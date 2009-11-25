require "user"

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
    @user.password.should be_instance_of(String)
    @user.password.length.should == 32
  end
  
  it "should have status" do
    @user.should respond_to(:status)
  end
  
  it "should be able to check if it is a SpyShopper" do
    @user.should respond_to(:is_spy_shopper)
  end
  
  it "should be able to check if it is a Client" do
    @user.should respond_to(:is_client)
  end
  
  it "should be able to check if it is a Manager" do
    @user.should respond_to(:is_manager)
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
  
  it "should be able to check if user exists" do
    User.should respond_to(:exists)
    User.exists(@user.login).should be_true
    User.exists("some-bad-login").should be_false
  end
  
  it "should be able to validate login and password" do
    User.should respond_to(:valid)
    User.valid("Person", "123").should be_true
    User.valid("Person", "999").should be_false
  end
  
  it "should be able to get list of SpyShoppers" do
    User.should respond_to(:spy_shoppers)
  end
  
  it "should be able to get list of Clients" do
    User.should respond_to(:clients)
  end
end  