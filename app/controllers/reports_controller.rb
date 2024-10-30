class ReportsController < ApplicationController
  def index
    if params[:report] == 'weekly_sales_report'
      report_data = fetch_weekly_stats
      @date_range = report_data[:date_range]
      @pagy, @weekly_stats = pagy_array(report_data[:stats].to_a, items: 10)
    else
      # Default to suburb report
      report_data = fetch_suburb_stats
      @date_range = report_data[:date_range]
      @pagy_suburb, @suburb_stats = pagy_array(report_data[:stats])
    end

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def export_csv
    respond_to do |format|
      format.csv do
        data = case params[:report_type]
               when 'suburb'
                 {
                   data: CsvService.generate_suburb_report(fetch_suburb_stats),
                   filename: "suburb_sales_report_#{Date.current.strftime('%Y%m%d')}.csv"
                 }
               else
                 {
                   data: CsvService.generate_weekly_report(fetch_weekly_stats),
                   filename: "weekly_sales_report_#{Date.current.strftime('%Y%m%d')}.csv"
                 }
               end

        send_data data[:data], 
                 filename: data[:filename],
                 disposition: 'attachment'
      end
    end
  end

  private

  def fetch_weekly_stats
    PropertySalesReportService.generate_weekly_report(
      start_date: date_params[:start_date],
      end_date: date_params[:end_date],
      sort_by: params[:sort_by],
      direction: params[:direction]
    )
  end

  def date_params
    @date_params ||= {
      start_date: params[:start_date].present? ? Date.parse(params[:start_date]) : Property.minimum(:sold_date),
      end_date: params[:end_date].present? ? Date.parse(params[:end_date]) : Date.current.end_of_week
    }
  end

  def fetch_suburb_stats
    report_data = SuburbSalesReportService.generate_report(
      start_date: date_params[:start_date],
      end_date: date_params[:end_date],
      sort_by: params[:sort_by],
      direction: params[:direction]
    )

    @date_range = report_data[:date_range]
    @pagy_suburb, @suburb_stats = pagy_array(report_data[:stats])

    report_data
  end
end