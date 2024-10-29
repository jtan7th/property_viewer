class PropertySalesReportService
    def self.generate_weekly_report(start_date:, end_date:)
      # Get all sold properties within date range
      sold_properties = Property.where(sold_date: start_date..end_date)
      
      # Group properties by week and count bedrooms
      weekly_stats = sold_properties.group_by { |prop| 
        prop.sold_date.beginning_of_week
      }.map do |week, properties|
        {
          week: week,
          total_sales: properties.count,
          bedroom_breakdown: {
            na_bed: properties.count { |p| p.bedroom_count.nil? || p.bedroom_count == 0 },
            one_bed: properties.count { |p| p.bedroom_count == 1 },
            two_bed: properties.count { |p| p.bedroom_count == 2 },
            three_bed: properties.count { |p| p.bedroom_count == 3 },
            four_bed: properties.count { |p| p.bedroom_count == 4 },
            five_plus_bed: properties.count { |p| p.bedroom_count.present? && p.bedroom_count >= 5 }
          }
        }
      end
  
      # Sort by week
      weekly_stats.sort_by { |stat| stat[:week] }
  
      {
        stats: weekly_stats,
        date_range: {
          start_date: weekly_stats.min_by { |stat| stat[:week] }[:week].to_date,
          end_date: weekly_stats.max_by { |stat| stat[:week] }[:week].to_date
        }
      }
    end
  end