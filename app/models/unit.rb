require 'couchrest_model'
class Unit < Hash
  include CouchRest::Model::CastedModel
  attr_accessor :casted_by

  property :content_type
  property :css_id
  property :unit_id
  
  def self.new_instance(params)
    case params['content_type']
    when 'menu'
      MenuUnit.new(params)
    when 'textbox'
      TextBoxUnit.new(params)
    when 'heading'
      HeadingUnit.new(params)
    when 'link'
      LinkUnit.new(params)
    when 'image'
      ImageUnit.new(params)
    when 'list'
      ListUnit.new(params)
    when 'table'
      TableUnit.new(params)
    when 'map'
      MapUnit.new(params)
    when 'reservation_form'
      ReservationsUnit.new(params)
    when 'download'
      DownloadUnit.new(params)
    when 'review'
      ReviewUnit.new(params)
    when 'contact_form'
      ContactFormUnit.new(params)
    else
      raise "unknown content type #{params.inspect}"
    end
  end
  
  def set_css_id
    page = casted_by
    new_id = Integer(page.existing_units(content_type)) + 1
    "#{content_type}_#{new_id}"
  end
  
end
