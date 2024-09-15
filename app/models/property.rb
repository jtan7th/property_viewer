class Property < ApplicationRecord
  has_many_attached :images

  # def image_urls_array
  #   if image_urls.is_a?(String)
  #     JSON.parse(image_urls)
  #   elsif image_urls.is_a?(Array)
  #     image_urls
  #   else
  #     []
  #   end
  # rescue JSON::ParserError
  #   []
  # end

  # def inspect
  #   attributes_for_inspect = attributes.dup
  #   attributes_for_inspect['image_urls'] = image_urls_array
  #   "#<#{self.class} #{attributes_for_inspect.map { |k,v| "#{k}: #{v.inspect}" }.join(', ')}>"
  # end
end