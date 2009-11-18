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
end