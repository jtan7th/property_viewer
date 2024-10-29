class ReportsController < ApplicationController
  def index
    start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : Property.minimum(:sold_date)
    end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : Date.current.end_of_week
    
    @weekly_stats = PropertySalesReportService.generate_weekly_report(
      start_date: start_date,
      end_date: end_date
    )
  end
end