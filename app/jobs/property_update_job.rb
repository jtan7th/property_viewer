class PropertyUpdateJob < ApplicationJob
  def perform
    PropertyScraperService.weekly_update
  end
end
