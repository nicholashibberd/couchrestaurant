class SittingsController < ApplicationController
  layout 'admin'
  
  def new
    @sitting = Sitting.new
  end
  
  def create_sitting
    sitting = Sitting.new(params[:sitting])
    @site.sittings << sitting
    @site.save
    redirect_to admin_path
  end

  def update_sitting
    sitting = @site.find_sitting(params[:sitting][:slug])
    sitting_number = @site.sittings.index(sitting)
    @site.sittings[sitting_number] = params[:sitting]
    @site.save
    redirect_to admin_path
  end
  
  def edit
    @sitting = @site.find_sitting(params[:id])
  end
end