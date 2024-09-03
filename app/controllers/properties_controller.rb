class PropertiesController < ApplicationController
  def index
    @properties = Property.all.order(:suburb, :address)
  end

  def show
    @property = Property.find(params[:id])
  end
end