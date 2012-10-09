require File.expand_path('../../lib/rubypedia', __FILE__)

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter = :documentation
end