class Property < ApplicationRecord
  include Statistical
  has_many_attached :images

  scope :price_range, ->(min, max) { 
    result = all
    result = result.where("sale_price >= ?", min) if min.present?
    result = result.where("sale_price <= ?", max) if max.present?
    result
  }
  scope :with_bedrooms, ->(count) { where(bedroom_count: count) if count.present? }
  scope :with_bathrooms, ->(count) { where(bathroom_count: count) if count.present? }
  scope :with_carparks, ->(count) { where(carpark_spaces_count: count) if count.present? }
  scope :floor_area_range, ->(min, max) { 
    where("floor_area >= ? AND floor_area <= ?", min, max) if min.present? && max.present?
  }
  scope :land_area_range, ->(min, max) { 
    where("land_area >= ? AND land_area <= ?", min, max) if min.present? && max.present?
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
end