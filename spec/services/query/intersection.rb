require 'rails_helper'

RSpec.describe Query::Intersection do
  use_vcr_cassette 'queries/not_verified', api_base_urls
  use_vcr_cassette 'queries/non_marketing', api_base_urls

  describe 'not_verified && non_marketing' do
    subject { described_class.new([Query::NotVerified.new, Query::NonMarketing.new]).results }

    it 'has specific row counts' do
      is_expected.to have_exactly(60).items
    end
  end

  describe 'non_marketing && not_verified' do
    subject { described_class.new([Query::NonMarketing.new, Query::NotVerified.new]).results }

    it 'has specific row counts' do
      is_expected.to have_exactly(60).items
    end
  end
end
