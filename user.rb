require "digest/md5"

class User
  
  def initialize(login, password)
    @login = login
    @password = Digest::MD5.hexdigest(password)
    @status = "active"
  end
  
  def is_spy_shopper
    self.instance_of? SpyShopper
  end
  
  def is_client
    self.instance_of? Client
  end
  
  def is_manager
    self.instance_of? Manager
  end
  
  attr :login
  attr :password
  attr_reader :status
  attr :id, true
  
  @db = {}
  @last_id = 0
  class << self
    attr :db, true
  end
  
  def User.insert(user)
    @last_id +=1
    user.id = @last_id
    
    if @db.keys.include? user.login
      raise "Login already exists"
    else
      @db[user.login] = user
    end
  end
  
  def User.exists(login)
    !@db[login].nil?
  end
  
  def User.valid(login, password)
    @db[login].password == Digest::MD5.hexdigest(password) and @db[login].status == "active"
  end
  
  def User.spy_shoppers
    list = {}
    @db.each do |key, value|
      if value.is_spy_shopper
        list[key] = value
      end
    end
    list
  end
  
end



