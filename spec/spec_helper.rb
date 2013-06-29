# Uncomment to check test coverage
# require 'simplecov'
# SimpleCov.start

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'pry'
require 'rspec'
require 'vcr'
require 'beta'

# Place sensitive gem configuration files in spec/configuration.yml and
# ensure that file is included in .gitignore to keep constants such as passwords
# and API keys private in publically released gems
CONFIGURATION_DEFAULTS = begin
  YAML::load_file("#{File.dirname(__FILE__)}/configuration.yml").inject({}) do |options, (key, value)|
    options[(key.to_sym rescue key) || key] = value
    options
  end
rescue
  # Create a hash of default configuration options
  { :api_key => 'ValidApiKey' }
end

def configuration_defaults
  CONFIGURATION_DEFAULTS
end

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # Use the treat_symbols_as_metadata_keys_with_true_values option to tell
  # RSpec that :key is shorthand for :key => true
  config.treat_symbols_as_metadata_keys_with_true_values = true

  # Restrict the examples run to only ones with the :focus filter
  config.filter_run :focus => true

  # Optionally ignore slow specs
  config.filter_run_excluding :slow if ENV["FAST_TESTS"]

  # Use the run_all_when_everything_filtered configuration option to do just
  # that. This works well when paired with an inclusion filter like ":focus =>
  # true", as it will run all the examples when none match the inclusion filter
  config.run_all_when_everything_filtered = true

end

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}





