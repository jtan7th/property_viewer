class PropertiesController < ApplicationController
  def index
    @properties = Property.all  # or whatever scope you're using

    if turbo_frame_request?
      render :index, layout: false
    else
      render :index
    end
  end

  def show
    @property = Property.find(params[:id])
    
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      redirect_to @property, notice: 'Property was successfully created.'
    else
      render :new
    end
  end

  def update
    @property = Property.find(params[:id])
    if @property.update(property_params)
      redirect_to @property, notice: 'Property was successfully updated.'
    else
      render :edit
    end
  end

  private

  def property_params
    params.require(:property).permit(:title, :description, :price, images: [])
  end
end