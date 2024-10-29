require 'pagy/extras/overflow'
require 'pagy/extras/array'

Pagy::DEFAULT.merge!(
  items: 10,
  overflow: :last_page,
  limit: 10
)