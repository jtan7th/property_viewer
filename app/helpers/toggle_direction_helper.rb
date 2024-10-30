module ToggleDirectionHelper
  def toggle_direction(column)
    current_direction = params[:direction] == 'asc' ? 'desc' : 'asc'
    next_direction = params[:sort_by] == column ? current_direction : 'asc'
    next_direction
  end

  def sort_indicator(column)
    # Show default descending indicator for sold_date when no sort params
    return '▼' if column == 'sold_date' && params[:sort_by].nil?
    # Show default ascending indicator for week
    return '▲' if column == 'week' && params[:sort_by].nil?
    # Original logic for explicit sorts
    return unless params[:sort_by] == column
    params[:direction] == 'asc' ? '▲' : '▼'
  end
end
