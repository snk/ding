#!/usr/bin/env ruby

require "user"
require "client"
require "manager"
require "spy_shopper"


class Ding
  
  def init
    puts " - SpyShoppers information system - \n\n"
    
    spy1 = SpyShopper.new('petras', '123', 22, 'Student, university')
    spy1.tasks[0] = {:client_id => 3, :description => "aplankyti musu kavine, tarp 10 ir 12 val ryto per pika"}
    spy2 = SpyShopper.new('jonas', '123', 25, 'Programmer, IT company')
    
    client = Client.new('cili', '123', "Cili Pica", "Laisves pr. 44, Vilnius")
    
    User.insert(spy1)
    User.insert(spy2)
    User.insert(client)
  end
  
  def authorization
    puts "Login: "
    login = gets.chomp.strip
    
    if User.exists(login)
      puts "Password: "
      password = gets.chomp.strip
      
      if User.valid(login, password)
        puts "\nChoose command (enter number or type 0 to exit): "
        
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
        when "1": user.tasks.each { |task| print task[:description], "\n"}
      end
      break if command == "0"
    end
  end
  
  def client_menu(user)
    puts "1. View spy shoppers list"
    puts "2. View my company info"
    puts "3. Update my company info"
    puts "4. Add task for spy shopper"
    
    while true
      command = gets.chomp.strip
      
      case command
        when "1": 
          print_spy_shoppers_list
          
        when "2": 
          puts user.company, user.address
          
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
            
            puts "Describe your task: "
            description = gets.chomp.strip
            
            spy.add_task(user, description)
            User.db[spy.login] = spy
            puts "Task successfully added"
            
          else
            puts "Login does not exists"
          end

      end
      break if command == "0"
    end
  end
  
  def print_spy_shoppers_list
    User.spy_shoppers.each { |login, spy| print login.ljust(10), " - ", spy.occupation, ", age: ", spy.age, "\n" }
  end
  
  Db_name = "db.yaml"
  
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