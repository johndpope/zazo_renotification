require 'rails_helper'

RSpec.describe Query::NotVerified, type: :model do
  subject { described_class.new.execute }

  around do |example|
    VCR.use_cassette('queries/not_verified') { example.run }
  end

  it 'has specific row counts' do
    is_expected.to have_exactly(1691).items
  end

  it_behaves_like 'query fields'
end
