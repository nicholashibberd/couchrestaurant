module ApplicationHelper
  def logo
   if FileTest.exist?(Rails.root.join("public", "images", "#{@site.theme}/logo.png"))
     link_to image_tag("#{@site.theme}/logo.png")
   else
     link_to @site.name
   end
  end
  
  def split_array_as_string(items)
    array = []
    items.split(',').each {|r| array << r.strip}
    array
  end
  
  def new_datetime(date, time)
    datetime = date + " " + time
    DateTime.parse(datetime)
  end
  
  def number_of_bookings(date, time)
    datetime = new_datetime(date, time)
    availability_hash = @site.by_time(datetime)["rows"]
    if availability_hash.empty?
      0
    else
      Integer(@site.by_time(datetime)["rows"].first["value"])
    end
  end
  
  def options_for_select_including_blank(collection, selected, blank)
    array = [[blank, nil]]
    collection.each {|item| array << [item.name, item.slug]}
    options_for_select(array, selected)
  end
      
end
