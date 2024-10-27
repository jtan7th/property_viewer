module ToggleDirectionHelper
  def toggle_direction(column)
    current_direction = params[:direction] == 'asc' ? 'desc' : 'asc'
    next_direction = params[:sort_by] == column ? current_direction : 'asc'
    next_direction
  end

  def sort_indicator(column)
    return unless params[:sort_by] == column
    params[:direction] == 'asc' ? '▲' : '▼'
  end
end
