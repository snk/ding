require "user"

Default_service_cost = 90

class Client < User
  def initialize(login, password, company, address)
    super(login, password)
    @company = company
    @address = address
    @balance = 0
    @max_debt = 0
    @service_cost = Default_service_cost
    @spy_shoppers = []
    @balance_log = []
  end
  
  def view_spy_shoppers
      
  end
  
  def add_task(spy_shopper, description)
    if balance_valid
      spy_shopper.tasks.push({"client_id" => self.id, "description" => description})
      add_balance(-@service_cost)
    else
      raise "Balance is not valid for adding task"
    end
  end
  
  def balance_valid
    @balance + @max_debt >= @service_cost
  end
  
  def add_balance(amount)
    @balance_log.push({"time" => Time.now.strftime("%Y-%m-%d %H:%M:%S"), "amount" => amount})
    @balance += amount
  end
  
  attr_accessor :company, :address, :max_debt, :service_cost
  attr_reader :spy_shoppers, :balance, :balance_log
  
end
