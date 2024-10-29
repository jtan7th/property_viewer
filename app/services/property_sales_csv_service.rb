require 'csv'

class PropertySalesCsvService
  def self.generate(weekly_stats)
    CSV.generate(headers: true) do |csv|
      csv << ['Week Starting', 'Total', 'N/A', '1 Bed', '2 Beds', '3 Beds', '4 Beds', '5+ Beds']
      
      weekly_stats.each do |stat|
        csv << [
          stat[:week].strftime('%B %d, %Y'),
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
end