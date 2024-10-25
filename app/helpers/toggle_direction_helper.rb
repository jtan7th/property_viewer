module ToggleDirectionHelper
  def toggle_direction(column)
    current_direction = params[:direction] == 'asc' ? 'desc' : 'asc'
    next_direction = params[:sort_by] == column ? current_direction : 'asc'
    next_direction
  end
end
