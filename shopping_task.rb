require "date"

class ShoppingTask
  
  attr_accessor :client, :spy, :spy_date, :description, :created, :status, :report
  
  def initialize(params)
    @client = params[:client]
    @spy = params[:spy]
    @spy_date = params[:spy_date]
    @description = params[:description]
    @status = params[:status]
    @created = DateTime.now
  end


  @tasks = []
  class << self
    attr_accessor :tasks
  end
  
  def ShoppingTask.insert(task)
    @tasks << task
  end
  
  def ShoppingTask.insert_report(task, report)
    # gal kartais sitos zemiau komandos turetu buti UI ir sitas metodas nereikalingas?
    @tasks.delete(task)
    task.report = report
    @tasks << task
  end
  
  def ShoppingTask.client(client)
    list = []
    tasks.each { |task| list << task unless task.client != client }
    list
  end
  
  def ShoppingTask.spy(spy)
    list = []
    tasks.each { |task| list << task unless task.spy != spy }
    list
  end
  
end
