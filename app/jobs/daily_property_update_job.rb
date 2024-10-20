class DailyPropertyUpdateJob < ApplicationJob
    queue_as :default
  
    def perform
      PropertyScraperService.daily_update
    end
  end