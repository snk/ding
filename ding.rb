#!/usr/bin/env /usr/local/bin/ruby

require "user"
require "client"
require "manager"
require "spy_shopper"
require "spy_schedule"
require "shopping_task"

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
    puts "2. View my schedule"
    puts "3. Add time to my schedule"
    
    while true
      command = gets.chomp.strip
      
      case command
        when "1" then
          
          ShoppingTask.spy(user).each_with_index { |task, id| print id + 1, ". ", task.description, "\n" }
          
        when "2" then
          print_spy_schedule(user)
          
        when "3" then
          print_spy_schedule(user)
          puts ""
          puts "Enter week (this, next): "
          week = gets.chomp.strip
          puts "Enter day (1 - Monday, 2 - Tuesday, ...): "
          day = gets.chomp.strip
          puts "Enter time interval start (format: hh:mm): "
          interval_start = gets.chomp.strip
          puts "Enter time interval end (format: hh:mm): "
          interval_end = gets.chomp.strip
          puts "Time interval was added to your schedule"
          
          now = Time.now
          if (week == 'this') then
            week = now.strftime("%W").to_i
          elsif (week == 'next') then
            now = now + (60 * 60 * 24 * 7)
            week = now.strftime("%W").to_i
          end

          user.schedule.add(now.year, week, day, interval_start, interval_end)
          
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
        when "1" then
          print_clients_list
          
        when "2" then
          puts "Choose client (enter login): "
          print_clients_list

          login = gets.chomp.strip
          if User.exists(login) && User.db[login].is_client
            puts "Enter amount (Lt): "
            amount = gets.chomp.strip.to_i
            client = User.db[login]
            client.add_balance(amount)
            User.db[login] = client
            #User
            puts "Balance successfully added"
            print "New balance: ", User.db[login].balance, " Lt\n"
          else
            puts "Login does not exists"
          end
          
        when "3" then
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
        when "1" then
          print_spy_shoppers_list
          
        when "2" then
          puts user.company, user.address
          print "Balance: ", user.balance, " Lt\n"
          print "Max debt: ", user.max_debt, " Lt\n"
          print "Service cost: ", user.service_cost, " Lt\n"
          
        when "3" then
          puts "Company name: "
          user.company = gets.chomp.strip
          puts "Address: "
          user.address = gets.chomp.strip
          
          User.db[user.login] = user
          puts "Info successfully updated"
          
        when "4" then
          puts "Choose spy shopper (enter login): "
          print_spy_shoppers_list
          login = gets.chomp.strip
          
          if User.exists(login) && User.db[login].is_spy_shopper
            spy = User.db[login]
            
            if user.balance_valid
              puts "Describe your task: "
              description = gets.chomp.strip
              
              puts "Choose spy shopper time (enter number): "
              print_spy_schedule(spy)
              
              schedule = gets.chomp.strip.to_i

              i = 0
              spy.schedule.current.each do |s|
                if s[:week] == 'current' then
                  i = i + 1
                  if (i == schedule) then
                    @date = s[:date]
                    @week = s[:week]
                    @time = s[:time]
                  end
                end
              end
              spy.schedule.current.each do |s|
                if s[:week] == 'next' then
                  i = i + 1
                  if (i == schedule) then
                    @date = s[:date]
                    @week = s[:week]
                    @time = s[:time]
                  end
                end
              end
              
              task = ShoppingTask.new({
                client: user, spy: spy, spy_date: {date: @date, week: @week, time: @time}, description: description, status: 'P'
              })
              
              user.add_task(task)
              spy.add_bonus(task)
              User.db[spy.login] = spy

              puts "Task successfully added"
            else
              puts "Your balance with max debt is too small for new task"
            end            
          else
            puts "Login does not exists"
          end
          
        when "5" then
          print "Current balance: ", user.balance, " Lt\n"
          print "Max balance: ", user.max_balance ," Lt\n\n"
          puts "Spending history: "
          user.balance_log_negative.each { |log| print log[:time], "   ", log[:amount], " Lt\n" }
          puts ""
          puts "Adding history: "
          user.balance_log_positive.each { |log| print log[:time], "   ", log[:amount], " Lt\n" }
          
        when "6" then
          user.assigned_tasks.each do |task| 
            print task["spy_shopper"].occupation, ", age: ", task["spy_shopper"].age, " - ", task["description"], "\n"
          end
      end
      break if command == "exit"
    end
  end
  
  def print_spy_shoppers_list
    User.spy_shoppers.each { |login, spy| print login.ljust(10), " - ", spy.occupation, ", age: ", spy.age, " [tasks done: ", spy.bonus_log.size ,"]\n" }
  end
  
  def print_clients_list
    User.clients.each do |login, client| 
      print login.ljust(10), " - ", client.company, " (", client.address, ") - balance: ", 
      client.balance," Lt, max debt: ", client.max_debt," Lt, service cost: ", client.service_cost," Lt\n"
    end
  end
  
  def print_spy_schedule(user)
    i = 0
    puts "This week: "
    user.schedule.current.each do |s|
      if s[:week] == 'current' then
        i = i + 1
        print i, ". ", s[:date], " ", s[:time], "\n"
      end
    end
    puts "Next week: "
    user.schedule.current.each do |s|
      if s[:week] == 'next' then
        i = i + 1
        print i, ". ", s[:date], " ", s[:time], "\n"
      end
    end
  end
  
  Db_name_users = "db-users.yml"
  Db_name_tasks = "db-tasks.yml"
  
  def save
    file = File.new(Db_name_users, "w")
    dump = Marshal.dump(User.db)
    file.write(dump)
    file.close    
    file = File.new(Db_name_tasks, "w")
    dump = Marshal.dump(ShoppingTask.tasks)
    file.write(dump)
    file.close
  end
  
  def load
    if File.exists? Db_name_users
      file = File.open(Db_name_users, "r")
      dump = file.read(File.size(Db_name_users))
      User.db = Marshal.load(dump)
      file.close
    end
    if File.exists? Db_name_tasks
      file = File.open(Db_name_tasks, "r")
      dump = file.read(File.size(Db_name_tasks))
      ShoppingTask.tasks = Marshal.load(dump)
      file.close
    end    
  end
end

system = Ding.new
#system.init
system.load
system.authorization
system.save
