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
  
  def add_task(task)
    if balance_valid
      ShoppingTask.insert(task)
      add_balance(-@service_cost)
    else
      raise "Balance is not valid for adding task"
    end
  end
  
  def balance_valid
    @balance + @max_debt - @service_cost >= 0
  end
  
  def max_balance
    @balance + @max_debt
  end
  
  def real_balance_valid
    @balance >= 0
  end
  
  def add_balance(amount)
    @balance_log << {:time => Time.now.strftime("%Y-%m-%d %H:%M:%S"), :amount => amount}
    @balance += amount
  end
  
  def balance_log_positive
    list = []
    balance_log.each { |b| list << b unless b[:amount] < 0 }
    list
  end
  
  def balance_log_negative
    list = []
    balance_log.each { |b| list << b unless b[:amount] >= 0 }
    list
  end
  
  def assigned_tasks
    list = []
    User.db.each_pair do |login, user|
      if user.is_spy_shopper
        user.tasks.each do |task|
          if task["client_id"] == self.id
            task["spy_shopper"] = user
            list.push(task)
          end
        end
      end
    end
    list
  end
  
  attr_accessor :company, :address, :max_debt, :service_cost
  attr_reader :spy_shoppers, :balance, :balance_log
  
end
