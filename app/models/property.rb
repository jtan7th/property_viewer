class Property < ApplicationRecord
  include Statistical
  has_many_attached :images

  scope :price_range, ->(min, max) { 
    result = all
    price_conditions = []
    price_conditions << "sale_price >= ?" if min.present?
    price_conditions << "sale_price <= ?" if max.present?
    
    if price_conditions.any?
      condition = price_conditions.join(' AND ')
      result = result.where("sale_price IS NULL OR (#{condition})", *[min, max].compact)
    end
    
    result
  }
  scope :with_bedrooms, ->(count) { where(bedroom_count: count) if count.present? }
  scope :with_bathrooms, ->(count) { where(bathroom_count: count) if count.present? }
  scope :with_carparks, ->(count) { where(carpark_spaces_count: count) if count.present? }
  scope :floor_area_range, ->(min, max) { 
    result = all
    result = result.where("floor_area >= ?", min) if min.present?
    result = result.where("floor_area <= ?", max) if max.present?
    result
  }
  scope :land_area_range, ->(min, max) { 
    result = all
    result = result.where("land_area >= ?", min) if min.present?
    result = result.where("land_area <= ?", max) if max.present?
    result
  }
  scope :in_suburb, ->(suburb) { where("suburb ILIKE ?", "%#{suburb}%") if suburb.present? }
  scope :built_in_decade, ->(decade) { where(decade_built: decade) if decade.present? }
  scope :in_condition, ->(condition) { where(condition: condition) if condition.present? }
  scope :with_deck, ->(has_deck) { where(deck: has_deck) if has_deck.present? }

  scope :sorted, ->(sort_option) do
    case sort_option
    when "sale_price_asc" then order(sale_price: :asc)
    when "sale_price_desc" then order(sale_price: :desc)
    when "created_at_desc" then order(created_at: :desc)
    when "created_at_asc" then order(created_at: :asc)
    when "land_area_asc" then order(land_area: :asc)
    when "land_area_desc" then order(land_area: :desc)
    else order(created_at: :desc)
    end
  end

  def self.sale_price_range
    min_price = minimum(:sale_price) || 0
    max_price = maximum(:sale_price) || 1000000
    { min: min_price, max: max_price }
  end
end