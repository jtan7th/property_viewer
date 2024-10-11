namespace :properties do
    desc "Clean up duplicate images and re-download for mismatched properties"
    task clean_and_redownload_images: :environment do
      properties = Property.where.not(image_urls: []).or(Property.where.not(image_urls: nil))
  
      properties.each do |property|
        unique_url_count = property.image_urls.uniq.count
        attached_image_count = property.images.count
  
        if attached_image_count != unique_url_count
          puts "Cleaning up images for Property ID: #{property.id}"
          
          # Remove all attached images
          property.images.purge
  
          # Queue job to re-download images
          DownloadImagesJob.perform_later(property.id)
          puts "Queued job to re-download images for Property ID: #{property.id}"
        end
      end
  
      puts "Cleanup and re-download process completed."
    end
  end