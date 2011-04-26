class DownloadsController < ApplicationController
    def create
      attachment_param = params[:attachment]
      link_text = params[:link_text]
      filename = File.basename(attachment_param.original_filename)
      content_type = attachment_param.content_type
      site = params[:site]
      slug = params[:slug]
      create_download(attachment_param, site, slug, content_type, filename)

      page = @site.find_page(slug)
      page.add_element('download', {:site => site, :slug => slug, :filename => filename, :link_text => link_text, :download_type => content_type})

      redirect_to :controller => 'pages', :action => 'edit', :id => slug
    end
    
    def create_download(attachment_param, site, slug, content_type, filename)
      if attachment_param.nil?
        flash[:message] = "No image selected to upload"
      else

        new_filename = Rails.root.join('public','downloads', "#{site}", "#{slug}", "#{filename}")
        target_directory = Rails.root.join('public','downloads', "#{site}", "#{slug}")

        if !File.directory?(target_directory)
          FileUtils.mkpath(target_directory)
        end

        File.open(new_filename, "wb") { |f| f.write(params[:attachment].read) }
      end
    end
    
    def download_document
      download = params[:download]
      return send_file Rails.root.join("public", "downloads", download['site'], download['slug'], download['filename']), :type => download['download_type'], :filename => download['filename']
    end
    
    
end