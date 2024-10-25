class ApplicationController < ActionController::Base
  include Pagy::Backend
  helper ToggleDirectionHelper
end
