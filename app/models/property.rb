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

  scope :bedroom_range, ->(min, max) {
    result = all
    if min.present? && min != 'Any'
      result = result.where('bedroom_count >= ?', min.to_i)
    end
    if max.present? && max != '5+'
      result = result.where('bedroom_count <= ?', max.to_i)
    elsif max == '5+'
      result = result.where('bedroom_count >= ?', 5)
    end
    result
  }
  scope :with_bathrooms, ->(count) { where(bathroom_count: count) if count.present? }
  scope :with_carparks, ->(count) { where(carpark_spaces_count: count) if count.present? }
  scope :floor_area_range, ->(min, max) { # this is to actually filter properties based on the floor area inputs
    result = all
    area_conditions = []
    area_conditions << "floor_area >= ?" if min.present?
    area_conditions << "floor_area <= ?" if max.present?
    
    if area_conditions.any?
      condition = area_conditions.join(' AND ')
      result = result.where("floor_area IS NULL OR (#{condition})", *[min, max].compact)
    end
    
    result
  }
  scope :land_area_range, ->(min, max) {
    result = all
    area_conditions = []
    area_conditions << "land_area >= ?" if min.present?
    area_conditions << "land_area <= ?" if max.present?
    
    if area_conditions.any?
      condition = area_conditions.join(' AND ')
      result = result.where("land_area IS NULL OR (#{condition})", *[min, max].compact)
    end
    
    result
  }
  scope :in_suburb, ->(suburb) { where("suburb ILIKE ?", "%#{suburb}%") if suburb.present? }
  scope :built_in_decade, ->(decade) { where(decade_built: decade) if decade.present? }
  scope :in_condition, ->(condition) { where(condition: condition) if condition.present? }
  scope :with_deck, ->(has_deck) { where(deck: has_deck) if has_deck.present? }
  scope :with_sale_price, -> { where.not(sale_price: nil) }
  scope :with_floor_area, -> { where.not(floor_area: nil) }
  scope :with_land_area, -> { where.not(land_area: nil) }

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

  def self.sale_price_bounds # this is used to set the bounds for the sale price slider
    min_price = minimum(:sale_price) || 0
    max_price = maximum(:sale_price) || 1000000
    { min: min_price, max: max_price }
  end

  def self.floor_area_bounds
    min_area = minimum(:floor_area) || 0
    max_area = maximum(:floor_area) || 1000
    range = { min: min_area, max: max_area }
  end
  
  def self.land_area_bounds
    min_land_area = minimum(:land_area) || 0
    max_land_area = maximum(:land_area) || 1000
    range = { min: min_land_area, max: max_land_area }
  end

  def self.bedroom_count_bounds
    min_bedrooms = where.not(bedroom_count: nil).minimum(:bedroom_count) || 0
    max_bedrooms = where.not(bedroom_count: nil).maximum(:bedroom_count) || min_bedrooms
    { min: min_bedrooms, max: max_bedrooms }
  end

  def self.filter(params)
    properties = all

    properties = properties.price_range(params[:min_sale_price], params[:max_sale_price])
    properties = properties.bedroom_range(params[:min_bedroom_count], params[:max_bedroom_count])
      .with_bathrooms(params[:bathroom_count])
      .with_carparks(params[:carpark_spaces_count])
      .floor_area_range(params[:min_floor_area], params[:max_floor_area])
      .land_area_range(params[:min_land_area], params[:max_land_area])
      .in_suburb(params[:suburb])
      .built_in_decade(params[:decade_built])
      .in_condition(params[:condition])
      .with_deck(params[:deck])
      .sorted(params[:sort_by])
    
    properties = properties.where("address ILIKE ?", "%#{params[:address]}%") if params[:address].present?
    properties = properties.with_sale_price if params[:exclude_nil_prices] == "1"
    properties = properties.with_floor_area if params[:exclude_nil_floor_areas] == "1"
    properties = properties.with_land_area if params[:exclude_nil_land_areas] == "1"

    properties
  end
end