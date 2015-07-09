require 'rails_helper'

RSpec.describe Query::NonMarketing, type: :model do
  subject { described_class.new.execute }

  around do |example|
    VCR.use_cassette('queries/non_marketing', api_base_urls) { example.run }
  end

  it 'has specific row counts' do
    is_expected.to have_exactly(197).items
  end

  it_behaves_like 'query fields'
end
