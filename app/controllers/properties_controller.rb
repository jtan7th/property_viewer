class PropertiesController < ApplicationController
  def index
    @filtered_properties = Property.filter(params)
    @pagy, @properties = pagy(@filtered_properties)
    @properties_stats = @filtered_properties
    @properties = @properties.sorted(params[:sort_by], params[:direction])


    respond_to do |format|
      format.html
      format.turbo_stream do
        if params[:page]
          render turbo_stream: [
            turbo_stream.append("properties-table-body", partial: "property_rows", locals: { properties: @properties }),
            turbo_stream.replace("properties-pagination", partial: "load_more", locals: { pagy: @pagy })
          ]
        else
          render turbo_stream: [
            turbo_stream.replace("properties-table", partial: "properties_table", locals: { properties: @properties, pagy: @pagy }),
            turbo_stream.replace("property-stats", partial: "property_stats", locals: { properties_stats: @properties_stats })
          ]
        end
      end
    end
  end

  def show
    @property = Property.find(params[:id])
    render layout: false if turbo_frame_request?
    
    if @property.images.none? && @property.image_urls.present?
      DownloadImagesJob.perform_later(@property.id)
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

  def filter_params
    params.permit(:min_sale_price, :max_sale_price, :min_bedroom_count, :max_bedroom_count,
                  :min_bathroom_count, :max_bathroom_count, :min_carpark_spaces_count, :max_carpark_spaces_count,
                  :min_floor_area, :max_floor_area, :min_land_area, :max_land_area,
                  :decade_built, :condition, :deck, :sort_by, :address,
                  :exclude_nil_prices, :exclude_nil_floor_areas, :exclude_nil_land_areas,
                  suburbs: []) # Add this line to accept an array of suburbs
  end
end
