class ReportsController < ApplicationController
  def index
    @weekly_stats = PropertySalesReportService.generate_weekly_report
  end
end