require File.expand_path('../../lib/rubypedia', __FILE__)

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter = :documentation
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture_content(filename)
  File.read [fixture_path, filename].join('/')
end
