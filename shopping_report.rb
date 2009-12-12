class ShoppingReport
  
  attr_accessor :date_start, :date_end, :kindness, :knowledge, :service, :tidiness, :attitude, :activity, :selling, :politeness
  
  def initialize(params)
    @date_start = params[:date_start]
    @date_end = params[:date_end]
    @kindness = params[:kindness]
    @knowledge = params[:knowledge]
    @service = params[:service]
    @tidiness = params[:tidiness]
    @attitude = params[:attitude]
    @activity = params[:activity]
    @selling = params[:selling]
    @politeness = params[:politeness]
  end
  
end
