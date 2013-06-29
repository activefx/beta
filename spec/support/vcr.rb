# Sample VCR setup
VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock #:typhoeus, :faraday, :fakeweb, or :webmock
  config.default_cassette_options = { :record => :new_episodes }
  config.configure_rspec_metadata!
  config.filter_sensitive_data('ValidApiKey') { configuration_defaults[:api_key] }
end
