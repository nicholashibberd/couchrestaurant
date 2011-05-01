class ReservationsController < ApplicationController
    
  def index
    @reservation = Reservation.all
  end
  
  def create
    @reservation = Reservation.new(params[:reservation])
      if @reservation.save
        #Contactmailer.reservation_customer_confirmation(@reservation).deliver
        #Contactmailer.reservation_info(@reservation).deliver
      else
        flash[:failure] = "Reservation Error Please call"
      end
      redirect_to :controller => 'reservations', :action => 'thankyou'
  end  
  
  def availability
    if params[:date]['select(1i)']      
      date_string = "#{params[:date]['select(3i)']}/#{params[:date]['select(2i)']}/#{params[:date]['select(1i)']}"
      @date = Date.strptime(date_string, '%d/%m/%Y')
    else
      @date = params[:date]
    end
    @sitting = @site.find_sitting(params[:sitting])
  end
  
  def details
    @reservation = Reservation.new
    @date = params[:date]
    @time = params[:time]
    @group_size = params[:group_size]
  end
  
  def load_partial
    @group_size = params[:group_size]
    @sitting = params[:sitting]
    respond_to do |format|
      format.js
      format.html
    end
  end
    
end