class PropertySalesReportService
    def self.generate_weekly_report(start_date:, end_date:, sort_by: nil, direction: nil)
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
  
      # Sort stats
      sorted_stats = if sort_by == 'week'
        weekly_stats.sort_by { |stat| stat[:week] }
                   .tap { |s| s.reverse! if direction == 'desc' }
      else
        # Default to ascending sort for week
        weekly_stats.sort_by { |stat| stat[:week] }
      end
  
      {
        stats: sorted_stats,
        date_range: {
          start_date: start_date,
          end_date: end_date
        }
      }
    end
  end