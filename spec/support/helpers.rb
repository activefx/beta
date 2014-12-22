module Helpers

  def fixture_path(name)
    File.expand_path("../fixtures/#{name}", File.dirname(__FILE__))
  end

end

RSpec.configure do |config|
  config.include Helpers
end
