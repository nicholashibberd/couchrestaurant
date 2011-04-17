module MenuSectionsHelper
  def new_menu_section(content_type)
    case content_type
      when 'menu_content' then render :partial => "menu_sections/new/menu_content"
      when 'dish' then render :partial => "menu_sections/new/dish"
    end
  end
end