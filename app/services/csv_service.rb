require 'csv'

class CsvService
  def self.generate_weekly_report(stats)
    CSV.generate do |csv|
      csv << ['Week Starting', 'Total Sales', 'N/A Beds', '1 Bed', '2 Beds', '3 Beds', '4 Beds', '5+ Beds']
      
      stats.each do |stat|
        csv << [
          stat[:week].strftime("%B %d, %Y"),
          stat[:total_sales],
          stat[:bedroom_breakdown][:na_bed],
          stat[:bedroom_breakdown][:one_bed],
          stat[:bedroom_breakdown][:two_bed],
          stat[:bedroom_breakdown][:three_bed],
          stat[:bedroom_breakdown][:four_bed],
          stat[:bedroom_breakdown][:five_plus_bed]
        ]
      end
    end
  end

  def self.generate_suburb_report(suburb_stats)
    CSV.generate(headers: true) do |csv|
      csv << ['Suburb', 'Total Sales', '3 Bed Sales', '4 Bed Sales', 'Median Sale Price']
      
      suburb_stats.each do |stat|
        csv << [
          stat[:suburb],
          stat[:total_sales],
          stat[:three_bed_sales],
          stat[:four_bed_sales],
          stat[:median_sale_price]
        ]
      end
    end
  end

  def self.generate_properties_report(properties)
    CSV.generate do |csv|
      csv << [
        # Basic Info
        'Address',
        'Suburb',
        'URL',
        
        # Sale Info
        'Sale Price',
        'Sale Date',
        
        # Property Details
        'Bedrooms',
        'Bathrooms',
        'Carpark Spaces',
        'Floor Area',
        'Land Area',
        'Decade Built',
        'Condition',
        
        # Features
        'Deck',
        'Property Contour',
        'View Type',
        'View Living Area',
        
        # Valuation Details
        'Capital Valuation',
        'Capital Valuation Date',
        'Land Value',
        'Improvement Value',
        
        # Homes Estimate
        'Homes Estimate Price',
        'Homes Estimate Date',
        'Homes Estimate Range Low',
        'Homes Estimate Range High',
        
        # Metadata
        'Last Updated'
      ]

      properties.each do |property|
        csv << [
          # Basic Info
          property.address,
          property.suburb,
          property.url,
          
          # Sale Info
          property.sale_price,
          property.sold_date&.strftime('%Y-%m-%d'),
          
          # Property Details
          property.bedroom_count,
          property.bathroom_count,
          property.carpark_spaces_count,
          property.floor_area,
          property.land_area,
          property.decade_built,
          property.condition,
          
          # Features
          property.deck,
          property.property_contour,
          property.view_type,
          property.view_living_area,
          
          # Valuation Details
          property.capital_valuation,
          property.capital_valuation_date&.strftime('%Y-%m-%d'),
          property.land_value,
          property.improvement_value,
          
          # Homes Estimate
          property.homes_estimate_price,
          property.homes_estimate_date&.strftime('%Y-%m-%d'),
          property.homes_estimate_range_low,
          property.homes_estimate_range_high,
          
          # Metadata
          property.last_updated&.strftime('%Y-%m-%d %H:%M:%S')
        ]
      end
    end
  end
end 