class ReportsController < ApplicationController
  def index
    report_data = fetch_weekly_stats
    @date_range = report_data[:date_range]
    sorted_stats = sort_stats(report_data[:stats])
    @pagy, @weekly_stats = pagy_array(sorted_stats.to_a, items: 10)
  end

  def export_csv
    respond_to do |format|
      format.csv do
        send_data PropertySalesCsvService.generate(fetch_weekly_stats), 
                 filename: "weekly_sales_report_#{Date.current.strftime('%Y%m%d')}.csv",
                 disposition: 'attachment'
      end
    end
  end

  private

  def sort_stats(stats)
    return stats unless params[:sort_by] == 'week'
    
    stats.sort_by { |stat| stat[:week] }
         .tap { |s| s.reverse! if params[:direction] == 'desc' }
  end

  def fetch_weekly_stats
    PropertySalesReportService.generate_weekly_report(
      start_date: date_params[:start_date],
      end_date: date_params[:end_date]
    )
  end

  def date_params
    @date_params ||= {
      start_date: params[:start_date].present? ? Date.parse(params[:start_date]) : Property.minimum(:sold_date),
      end_date: params[:end_date].present? ? Date.parse(params[:end_date]) : Date.current.end_of_week
    }
  end
end