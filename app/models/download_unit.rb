class DownloadUnit < Unit  
  property :filename
  property :slug
  property :site
  property :download_type  
  property :link_text
  
  def delete_download
    download_file = Rails.root.join('public', 'downloads', "#{self.site}", "#{self.slug}", "#{self.filename}")
    FileUtils.rm(download_file)
  end
end  
