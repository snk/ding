require "digest/md5"

class User
  def initialize(login, password)
    @login = login
    @password = Digest::MD5.hexdigest(password)
    @status = "active"
  end
  
  attr :login
  attr :password
  attr_reader :status
  
end



