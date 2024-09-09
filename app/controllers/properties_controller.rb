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
end