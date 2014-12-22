require 'vcr'
require 'webmock/rspec'

def sensitive_keys
  keys = []
  begin
    File.open(File.expand_path('../../.env', File.dirname(__FILE__))) do |key_file|
      key_file.each do |line|
        if line =~ /_key|_id|_secret/i
          keys << /(?<=\=).+/.match(line.strip).to_s
        end
      end
    end
  rescue Errno::ENOENT; end
  keys
end

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = false
  c.ignore_localhost = false
  c.cassette_library_dir = File.join(File.dirname(__FILE__), '..', 'cassettes')
  c.hook_into :webmock #:typhoeus, :faraday, :fakeweb, or :webmock
  c.default_cassette_options = { :record => :new_episodes }
  c.configure_rspec_metadata!
  # Filter any values from the .env file
  sensitive_keys.each do |sensitive_value|
    unless sensitive_value.nil?
      c.filter_sensitive_data('<HIDDEN>') { sensitive_value }
    end
  end
end

RSpec.configure do |config|
  config.include WebMock::API
end
