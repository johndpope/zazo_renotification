require 'rails_helper'

RSpec.describe Query::SpecificUsers, type: :model do
  use_vcr_cassette 'queries/specific_users', api_base_urls
  subject { described_class.new(params: params).execute }
  let(:users) { '0QZKM0xguRhf33PhJ5Vg 0STznMncWKqsmd5FhM3P' }

  describe 'with arguments' do
    context 'default' do
      let(:params) { nil }
      it { is_expected.to have_exactly(0).items }
    end

    context '2015-05-15 00:00 with passing' do
      let(:params) { users }
      it { is_expected.to have_exactly(2).items }
    end
  end

  describe 'validations' do
    context 'too many arguments' do
      let(:params) { 'first,second' }
      it { expect { subject }.to raise_error(Query::ArgumentError) }
    end
  end

  describe 'query fields' do
    let(:params) { users }
    it_behaves_like 'query fields'
  end
end
