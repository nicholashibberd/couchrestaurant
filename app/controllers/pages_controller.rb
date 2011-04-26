class PagesController < ApplicationController
  layout :pages_layout
  include PagesHelper
  uses_yui_editor

  def new
    @page = Page.new
  end

  def index
    @pages = @site.pages
  end

  def edit
    @page = @site.find_page(params[:id])
    if request.post?
      unless params[:page].nil?
        @page.update_elements(params[:page][:units])
      end
      if params[:commit] == 'Add menu'
        @page.add_element('menu', nil)
      elsif params[:commit] == 'Add textbox'
        @page.add_element('textbox', nil)
      elsif params[:commit] == 'Add link'
        @page.add_element('link', nil)
      elsif params[:commit] == 'Add heading'
        @page.add_element('heading', nil)
      elsif params[:commit] == 'Add table'
        @page.add_element('table', nil)  
      elsif params[:commit] == 'Add map'
        @page.add_element('map', nil)  
      elsif params[:commit] == 'Add reservation form'
        @page.add_element('reservation_form', nil)  
      elsif params[:commit] == 'Add image'
        @page.add_element('image', {:site => 'theivy', :slug => 'home', :filename => 'test'})
      elsif params[:commit] == 'Add download'
        @page.add_element('download', nil)  
      elsif params[:commit] == 'Save'
        #raise params[:page][:units].inspect
        @page.save
      end
      if params[:add_dish]
        @page.add_dish(params[:add_dish])  
      end
      if params[:delete]
        @page.delete_element(params[:delete])
      end
    end
  end
  
  def show
    if params[:sub_id]
      slug = "#{params[:id]}/#{params[:sub_id]}"
    else
      slug = params[:id]
    end
    @page = @site.find_page(slug)
    @reservation = Reservation.new
    @message = Message.new
  end
  
  def create
    @page = Page.new(params[:page])
      if @page.save
        redirect_to edit_page_path(@page)
      else
        render 'pages/new'
      end
  end
  
  def update
    @page = @site.find_page('units_test')
    if @page.update_attributes(params[:page])
      redirect_to :controller => 'pages', :action => 'show', :id => @page.slug
    else
      render 'admin/menus/new'
    end
  end
  
  def pages_layout
    request[:action] == 'show' ? choose_layout : 'admin'
  end
  
  def edit_unit
    @page = @site.find_page(params[:id])
  end
  
  def update_unit
    @page = @site.find_page(params[:id])
    raise params.inspect
  end  
  
end