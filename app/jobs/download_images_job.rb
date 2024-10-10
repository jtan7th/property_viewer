require 'open-uri'

class DownloadImagesJob < ApplicationJob
    queue_as :default

    def perform(property_id)
      property = Property.find(property_id)
      
      # Your image downloading logic here
      # For example:
      # download_images(property)

      # After downloading is complete
      property.update(download_job_id: nil)
    end

    private

    def download_images(property)
      # Simulate downloading images
      sleep 5 # Simulate a 5-second download time
      # Attach some dummy images (replace this with your actual image downloading logic)
      3.times do |i|
        property.images.attach(io: StringIO.new, filename: "image_#{i+1}.jpg", content_type: "image/jpeg")
      end
    end
end