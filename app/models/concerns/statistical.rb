module Statistical
    extend ActiveSupport::Concern
  
    class_methods do
      def median(attribute)
        values = pluck(attribute).compact
        return 0 if values.empty?
  
        sorted_values = values.sort
        mid = sorted_values.length / 2
        sorted_values.length.odd? ? sorted_values[mid] : (sorted_values[mid-1] + sorted_values[mid]) / 2.0
      end
    end
  end