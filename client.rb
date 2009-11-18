require "user"

class Client < User
  def initialize(login, password, company, address)
    super(login, password)
    @company = company
    @address = address
    @spy_shoppers = []
  end
  
  def view_spy_shoppers
      
  end
  
  attr :company
  attr :address
  attr :spy_shoppers
  
end
