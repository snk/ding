#!/usr/bin/env ruby

require "user"
require "client"
require "manager"
require "spy_shopper"


class Ding
  
  def init
    puts " - SpyShoppers information system - \n\n"
    
    spy1 = SpyShopper.new('petras', '123', 22, 'Student, university')
    spy2 = SpyShopper.new('jonas', '123', 25, 'Programmer, IT company')
    client = Client.new('cili', '123', "Cili Pica", "Laisves pr. 44, Vilnius")
    manager = Manager.new('manager', '123')
    
    User.insert(spy1)
    User.insert(spy2)
    User.insert(client)
    User.insert(manager)
  end
  
  def authorization
    puts "Login: "
    login = gets.chomp.strip
    
    if User.exists(login)
      puts "Password: "
      password = gets.chomp.strip
      
      if User.valid(login, password)
        puts "\nChoose command (enter number or type 'exit' to exit): "
        
        user = User.db[login]
        if user.is_spy_shopper
          spy_shopper_menu(user)
        elsif user.is_manager
          manager_menu(user)
        elsif user.is_client
          client_menu(user)
        end
      else
        puts "ERROR: Password is not valid"
      end
      
    else
      puts "ERROR: Such login does not exists"
    end
  end
  
  def spy_shopper_menu(user)
    puts "1. View assigned tasks"
    while true
      command = gets.chomp.strip
      
      case command
        when "1": 
          user.tasks.each_with_index do |task, id|
            
            print id + 1, ". ", task["description"], "\n"
          end
      end
      break if command == "exit"
    end
  end
  
  def manager_menu(user)
    puts "1. View client list"
    puts "2. Add clients balance"
    puts "3. Set clients service cost and max allowed debt"
    
    while true
      command = gets.chomp.strip
      
      case command
        when "1": 
          print_clients_list
          
        when "2": 
          puts "Choose client (enter login): "
          print_clients_list

          login = gets.chomp.strip
          if User.exists(login) && User.db[login].is_client
            puts "Enter amount (Lt): "
            amount = gets.chomp.strip.to_i
            client = User.db[login]
            client.add_balance(amount)
            User.db[login] = client
            User
            puts "Balance successfully added"
            print "New balance: ", User.db[login].balance, " Lt\n"
          else
            puts "Login does not exists"
          end
          
        when "3":
          puts "Choose client (enter login): "
          print_clients_list

          login = gets.chomp.strip
          if User.exists(login) && User.db[login].is_client
            puts "Enter service cost (Lt): "
            cost = gets.chomp.strip.to_i
            puts "Enter max allowed debt (Lt): "
            debt = gets.chomp.strip.to_i
            
            User.db[login].service_cost = cost
            User.db[login].max_debt = debt
            puts "Info successfully added"
          else
            puts "Login does not exists"
          end
      end
      break if command == "exit"
    end
  end
  
  def client_menu(user)
    puts "1. View spy shoppers list"
    puts "2. View my company info"
    puts "3. Update my company info"
    puts "4. Add task for spy shopper"
    puts "5. View my balance history"
    puts "6. View my assigned tasks"
    
    while true
      command = gets.chomp.strip
      
      case command
        when "1": 
          print_spy_shoppers_list
          
        when "2": 
          puts user.company, user.address
          print "Balance: ", user.balance, " Lt\n"
          print "Max debt: ", user.max_debt, " Lt\n"
          print "Service cost: ", user.service_cost, " Lt\n"
          
        when "3": 
          puts "Company name: "
          user.company = gets.chomp.strip
          puts "Address: "
          user.address = gets.chomp.strip
          
          User.db[user.login] = user
          puts "Info successfully updated"
          
        when "4": 
          puts "Choose spy shopper (enter login): "
          print_spy_shoppers_list
          login = gets.chomp.strip
          
          if User.exists(login) && User.db[login].is_spy_shopper
            spy = User.db[login]
            
            if user.balance_valid
              puts "Describe your task: "
              description = gets.chomp.strip
            
              user.add_task(spy, description)
              User.db[spy.login] = spy
              puts "Task successfully added"
            else
              puts "Your balance with max debt is too small for new task"
            end            
          else
            puts "Login does not exists"
          end
          
        when "5":
          print "Current balance: ", user.balance, " Lt\n"
          puts "History: "
          user.balance_log.each { |log| print log["time"], "   ", log["amount"], " Lt\n" }
          
        when "6": 
          user.assigned_tasks.each do |task| 
            print task["spy_shopper"].occupation, ", age: ", task["spy_shopper"].age, " - ", task["description"], "\n"
          end
      end
      break if command == "exit"
    end
  end
  
  def print_spy_shoppers_list
    User.spy_shoppers.each { |login, spy| print login.ljust(10), " - ", spy.occupation, ", age: ", spy.age, "\n" }
  end
  
  def print_clients_list
    User.clients.each do |login, client| 
      print login.ljust(10), " - ", client.company, " (", client.address, ") - balance: ", 
      client.balance," Lt, max debt: ", client.max_debt," Lt, service cost: ", client.service_cost," Lt\n"
    end
  end
  
  Db_name = "db.yml"
  
  def save
    file = File.new(Db_name, "w")
    dump = Marshal.dump(User.db)
    file.write(dump)
    file.close
  end
  
  def load
    if File.exists? Db_name
      file = File.open(Db_name, "r")
      dump = file.read(File.size(Db_name))
      User.db = Marshal.load(dump)
      file.close
    end
  end
end

system = Ding.new
#system.init
system.load
system.authorization
system.save