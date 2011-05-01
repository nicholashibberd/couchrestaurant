module UnitsHelper

  def display_unit(unit, action, index)
    content_type = unit['content_type']
    render :partial => "units/#{action}/#{content_type}", :locals => {:unit => unit, :index => index}
  end
    
  def new_unit(content_type)
    render :partial => "units/new/#{content_type}"
  end
  
  def info_window_string(content)
    content_tag(:div, content)
  end
  
end
