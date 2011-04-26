class ReservationsController < ApplicationController
    
  def index
    @reservation = Reservation.all
  end
  
  def create
    @page = @site.find_page(params[:page_id])
    @reservation = Reservation.new(params[:reservation])
      if @reservation.save
        #Contactmailer.reservation_customer_confirmation(@reservation).deliver
        #Contactmailer.reservation_info(@reservation).deliver
        flash[:success] = "Thank you for your reservation!"
      else
        flash[:failure] = "Reservation Error Please call"
      end
      redirect_to :controller => 'pages', :action => 'show', :id => @page.slug
  end  
  
  def availability
    @date = params[:date]
  end
  
end