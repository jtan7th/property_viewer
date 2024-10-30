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
end 