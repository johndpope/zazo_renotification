VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.default_cassette_options = { record: :once }
end


def api_base_urls
  { erb: {
    events_api_base_url: Figaro.env.events_api_base_url,
    statistics_api_base_url: Figaro.env.statistics_api_base_url
  }}
end
