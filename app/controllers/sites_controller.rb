class SitesController < ApplicationController
  def index
    @sites = Site.all
  end
  
  def show
    @site = Site.find_by_name(params[:id])
  end
  
  def create
    if Site.create params[:site]
      flash[:success] = "it worked"
    else
      flash[:error] = "it failed"
    end
    redirect_to sites_path
  end
    
end