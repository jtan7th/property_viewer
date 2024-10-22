class PropertyUpdateJob < ApplicationJob
    queue_as :default
  
    def perform
      PropertyScraperService.weekly_update
    end
  end
