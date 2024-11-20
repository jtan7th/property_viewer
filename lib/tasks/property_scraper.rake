namespace :property_scraper do
  desc "Run weekly update of property data with detailed logging"
  task weekly_update: :environment do
    puts "=== Starting Property Scraper Weekly Update ==="
    puts "Time: #{Time.current}"
    puts "Environment: #{Rails.env}"
    
    begin
      PropertyScraperService.new.perform
      puts "=== Property Scraper Completed Successfully ==="
      puts "Properties count: #{Property.count}"
      puts "Latest property created: #{Property.last&.created_at}"
    rescue => e
      puts "=== Property Scraper Failed ==="
      puts "Error: #{e.message}"
      puts "Backtrace:"
      puts e.backtrace
      raise e
    end
  end
end
