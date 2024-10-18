namespace :property_scraper do
  desc "Run daily update of property data"
  task daily_update: :environment do
    PropertyScraperService.daily_update
  end
end
