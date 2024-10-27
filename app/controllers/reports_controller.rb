class ReportsController < ApplicationController
    def index
      @start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : 1.month.ago.to_date
      @end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : Date.today
  
      @sales_by_suburb = Sale.where(date: @start_date..@end_date)
                            .group(:suburb)
                            .count
    end
  end