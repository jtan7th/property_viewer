# Right now this works in terms of scraping everything, but it really should only be scraping new stuff or if price isn't there so need to debug this
# make also need to make this a job, not a task, although we can keep the code as a service
class PropertyScraperService
    def self.daily_update
      new.daily_update
    end
  
    def daily_update
      base_urls.each_with_index do |base_url, base_index|
        process_base_url(base_url, base_index)
      end
      Rails.logger.info "Daily update completed."
    end
  
    private
  
    def process_base_url(base_url, base_index)
      Rails.logger.info "Processing base URL #{base_index + 1} of #{base_urls.length}: #{base_url}"
      
      urls = UrlScraperService.scrape_property_urls(base_url)
      Rails.logger.info "Found #{urls.length} property URLs for this base URL"
  
      urls.each_with_index do |url, index|
        process_property(url, index, urls.length)
      end
  
      sleep(5) # Optional delay between base URLs
    end
  
    def process_property(url, index, total)
      Rails.logger.info "Processing property #{index + 1} of #{total}: #{url}"
      scrape_and_update_property(url)
      sleep(2) # Optional delay between requests
    end
  
    def scrape_and_update_property(url)
      property = Property.find_or_initialize_by(url: url)

      if property.new_record? || property.needs_update?
        update_property(property, url)
      else
        Rails.logger.info "Property is up-to-date: #{url}"
      end
    end
  
    def update_property(property, url)
      Rails.logger.info "Scraping property: #{url}"
      property_data = SeleniumScraperService.scrape(url)
      
      if property_data
        save_property(property, property_data)
      else
        Rails.logger.error "Failed to scrape property: #{url}"
      end
    end
  
    def save_property(property, property_data)
      property.assign_attributes(property_data)
      property.last_updated = Time.current
      
      begin
        property.save!
        Rails.logger.info "Property saved successfully with ID: #{property.id}"
      rescue ActiveRecord::RecordInvalid => e
        Rails.logger.error "Failed to save property: #{e.message}"
        Rails.logger.error "Property data: #{property.attributes.inspect}"
      end
    end
  
    def base_urls
      @base_urls ||= YAML.load_file(Rails.root.join('config', 'base_urls.yml'))['base_urls']
    end
  end
