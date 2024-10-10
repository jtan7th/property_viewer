namespace :properties do
    desc "Download images for properties that don't have any"
    task download_missing_images: :environment do
      properties = Property.where.not(image_urls: []).or(Property.where.not(image_urls: nil))
                           .select { |p| p.images.none? }
  
      total = properties.count
      puts "Found #{total} properties with missing images. Starting download..."
  
      properties.each_with_index do |property, index|
        DownloadImagesJob.perform_later(property.id)
        puts "Queued job for Property ID: #{property.id} (#{index + 1}/#{total})"
      end
  
      puts "All jobs queued. Images will be downloaded in the background."
    end
  end