module ApplicationHelper
  def logo
   if FileTest.exist?(Rails.root.join("public", "images", "#{@site.theme}/logo.png"))
     link_to image_tag("#{@site.theme}/logo.png")
   else
     link_to @site.name
   end
  end
  
end
