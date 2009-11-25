require "user"

class Manager < User
  
  def initialize(login, password)
    super(login, password)
  end
  
  def add_clients_balance(client, amount)
    User.db[client.login].add_balance(amount)
  end
  
  def set_clients_max_debt(client, max_debt)
    User.db[client.login].max_debt = max_debt
  end
end