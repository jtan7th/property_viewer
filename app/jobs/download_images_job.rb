require 'open-uri'


class DownloadImagesJob < ApplicationJob
    queue_as :default
  
    def perform(property_id)
      property = Property.find(property_id)
      
      property.image_urls.uniq.each_with_index do |url, index|
        begin
          downloaded_image = URI.open(url)
          property.images.attach(io: downloaded_image, filename: "property_#{property.id}_image_#{index}.jpg")
        rescue OpenURI::HTTPError, SocketError => e
          Rails.logger.error "Failed to download image for Property #{property.id}: #{e.message}"
        end
      end
    end
  end