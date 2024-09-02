class PropertiesController < ApplicationController
  def index
    @properties = Property.all.order(sold_date: :desc)
  end

  def show
    @property = Property.find(params[:id])
  end
end