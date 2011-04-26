class MessagesController < ApplicationController
    
  def index
    @messages = Message.all
  end
  
  def create
    @page = @site.find_page(params[:page_id])
    @message = Message.new(params[:message])
      if @message.save
        Contactmailer.contact_form_message(@message).deliver
        flash[:success] = "Thank you for your message!"
      else
        flash[:failure] = "Message did not submit"
      end
      redirect_to :controller => 'pages', :action => 'show', :id => @page.slug
  end  
  
end