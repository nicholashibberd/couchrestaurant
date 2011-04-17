class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :setup_site
  layout :choose_layout

  def setup_site
    @site = Site.find_by_domain(request.domain(2))
  end
  
  def choose_layout
      @site.theme
  end
  
end
