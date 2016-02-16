require 'rails_helper'

RSpec.describe Query::Intersection do
  use_vcr_cassette 'queries/not_verified', api_base_urls
  use_vcr_cassette 'queries/non_marketing', api_base_urls

  let(:instance) { described_class.new queries }

  describe '#results' do
    subject { instance.results }

    context 'not_verified && non_marketing' do
      let(:queries) { [Query::NotVerified.new, Query::NonMarketing.new] }
      it { is_expected.to have_exactly(1363).items }
    end

    context 'non_marketing && not_verified' do
      let(:queries) { [Query::NonMarketing.new, Query::NotVerified.new] }
      it { is_expected.to have_exactly(1363).items }
    end

    context 'not_verified' do
      let(:queries) { [Query::NotVerified.new] }
      it { is_expected.to have_exactly(2984).items }
    end

    context 'non_marketing' do
      let(:queries) { [Query::NonMarketing.new] }
      it { is_expected.to have_exactly(2224).items }
    end
  end
end
