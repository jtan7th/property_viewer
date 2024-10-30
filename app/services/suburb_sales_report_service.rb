class SuburbSalesReportService
    def self.generate_report(start_date:, end_date:, sort_by: nil, direction: nil)
      # Get all sold properties within date range
      properties = Property.where(sold_date: start_date..end_date)
      
      # Group and calculate stats by suburb
      suburb_stats = properties.group_by(&:suburb).map do |suburb, suburb_properties|
        {
          suburb: suburb,
          total_sales: suburb_properties.count,
          three_bed_sales: suburb_properties.count { |p| p.bedroom_count == 3 },
          four_bed_sales: suburb_properties.count { |p| p.bedroom_count == 4 },
          median_sale_price: calculate_median_price(suburb_properties)
        }
      end
  
      # Sort stats
      sorted_stats = if sort_by.present?
        suburb_stats.sort_by { |stat| stat[sort_by.to_sym] || '' }
                   .tap { |s| s.reverse! if direction == 'desc' }
      else
        # Default to ascending sort by suburb
        suburb_stats.sort_by { |stat| stat[:suburb] || '' }
      end
  
      {
        stats: sorted_stats,
        date_range: {
          start_date: start_date,
          end_date: end_date
        }
      }
    end
  
    private
  
    def self.calculate_median_price(properties)
      prices = properties.map(&:sale_price).compact.sort
      return nil if prices.empty?
  
      middle = prices.length / 2
      if prices.length.odd?
        prices[middle]
      else
        (prices[middle - 1] + prices[middle]) / 2
      end
    end
  end