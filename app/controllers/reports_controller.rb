class ReportsController < ApplicationController
  def index
    if params[:report].present?
      @report_type = params[:report].to_sym
      report_data = fetch_report_data
      
      @date_range = report_data[:date_range]
      @pagy, @stats = pagy_array(report_data[:stats].to_a, items: 10)

      respond_to do |format|
        format.html
        format.turbo_stream { render_turbo_stream_response }
      end
    else
      respond_to do |format|
        format.html
        format.turbo_stream
      end
    end
  end

  def export_csv
    respond_to do |format|
      format.csv do
        report_type = params[:report_type].to_s
        data = {
          data: generate_csv_for(report_type),
          filename: generate_filename_for(report_type)
        }

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

  def fetch_report_data
    case @report_type
    when /weekly_sales/
      fetch_weekly_stats
    when /suburb/
      fetch_suburb_stats
    end
  end

  def render_turbo_stream_response
    frame_id = frame_id_for_report
    if turbo_frame_request_id == frame_id
      render_table_update(frame_id)
    else
      render_content_update
    end
  end

  def frame_id_for_report
    @report_type.to_s.include?('weekly') ? 'weekly_sales_table' : 'suburb_table'
  end

  def report_locals_key
    @report_type.to_s.include?('weekly') ? :weekly_stats : :suburb_stats
  end

  def render_table_update(frame_id)
    render turbo_stream: turbo_stream.update(frame_id,
      partial: "#{@report_type}_table",
      locals: { report_locals_key => @stats }
    )
  end

  def render_content_update
    render turbo_stream: turbo_stream.update('report_content',
      partial: @report_type.to_s,
      locals: { report_locals_key => @stats }
    )
  end

  def generate_csv_for(report_type)
    csv_generators = {
      'suburb' => -> { CsvService.generate_suburb_report(fetch_suburb_stats[:stats]) },
      'weekly' => -> { CsvService.generate_weekly_report(fetch_weekly_stats[:stats]) }
    }

    generator = csv_generators[report_type] || csv_generators['weekly']
    generator.call
  end

  def generate_filename_for(report_type)
    "#{report_type}_sales_report_#{Date.current.strftime('%Y%m%d')}.csv"
  end
end