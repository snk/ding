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
  
  def add_task(spy_shoppers, notes)
    
  end
  
  attr :company, true
  attr :address, true
  attr :spy_shoppers
  
end
