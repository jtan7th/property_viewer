class PropertiesController < ApplicationController
  def index
    @properties = Property.all
      .price_range(params[:min_sale_price], params[:max_sale_price])
      .with_bedrooms(params[:bedroom_count])
      .with_bathrooms(params[:bathroom_count])
      .with_carparks(params[:carpark_spaces_count])
      .floor_area_range(params[:min_floor_area], params[:max_floor_area])
      .land_area_range(params[:min_land_area], params[:max_land_area])
      .in_suburb(params[:suburb])
      .built_in_decade(params[:decade_built])
      .in_condition(params[:condition])
      .with_deck(params[:deck])
      .sorted(params[:sort_by])
    @properties = @properties.where("address ILIKE ?", "%#{params[:address]}%") if params[:address].present?

    # If using the model method or concern:
    @median_price = @properties.median(:sale_price)
    @median_homes_estimate_price = @properties.median(:homes_estimate_price)

    respond_to do |format|
      format.html
      format.turbo_stream do
        Rails.logger.debug "Responding with Turbo Stream"
        render turbo_stream: [
          turbo_stream.replace("properties", partial: "properties_table", locals: { properties: @properties }),
          turbo_stream.replace("property-stats", partial: "property_stats"),
          turbo_stream.replace("modal", partial: "filter_modal")
        ]
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