module UnitsHelper

  def display_unit(unit, action)
    case unit['content_type']
      when 'textbox' then render :partial => "units/#{action}/textbox_unit", :locals => {:unit => unit}
      when 'menu' then render :partial => "units/#{action}/menu_unit", :locals => {:unit => unit}
      when 'heading' then render :partial => "units/#{action}/heading_unit", :locals => {:unit => unit}  
      when 'link' then render :partial => "units/#{action}/link_unit", :locals => {:unit => unit}          
      when 'image' then render :partial => "units/#{action}/image_unit", :locals => {:unit => unit}          
    end    
  end
  
  def display_unit_with_index(unit)
    case unit[0]['content_type']
      when 'menu' then render :partial => "units/index/menu_unit", :locals => {:unit => unit}
      when 'textbox' then render :partial => "units/index/textbox_unit", :locals => {:unit => unit}
      when 'heading' then render :partial => "units/index/heading_unit", :locals => {:unit => unit}  
      when 'link' then render :partial => "units/index/link_unit", :locals => {:unit => unit}          
      when 'image' then render :partial => "units/index/image_unit", :locals => {:unit => unit}          
    end
  end
  
  def page_unit_new(content_type)
    case content_type
      when 'menu' then render :partial => "units/new/menu_unit"
      when 'textbox' then render :partial => "units/new/textbox_unit"
      when 'heading' then render :partial => "units/new/heading_unit"
      when 'link' then render :partial => "units/new/link_unit"
      when 'image' then render :partial => "units/new/image_unit"
    end
  end
  
end
