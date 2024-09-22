class PropertiesController < ApplicationController
  def index
    @properties = Property.all
    @properties = @properties.where("address ILIKE ?", "%#{params[:address]}%") if params[:address].present?

    puts "Address param: #{params[:address]}"
    puts "Properties count: #{@properties.count}"

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("properties", partial: "properties_table", locals: { properties: @properties })
      end
    end
  end

  def show
    @property = Property.find(params[:id])
    
    if @property.images.none?
      DownloadImagesJob.perform_now(@property.id)
    end
  end

  def filter_modal
    # Add any necessary logic here
    render layout: false
  end

  private

  def property_params
    params.require(:property).permit(:title, :description, :price, images: [])
  end

  def numeric_column?(column_name)
    Property.column_for_attribute(column_name).type.in?([:integer, :float, :decimal])
  end
end