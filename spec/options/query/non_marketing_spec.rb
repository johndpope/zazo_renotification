require 'rails_helper'

RSpec.describe Query::NonMarketing, type: :model do
  use_vcr_cassette 'queries/non_marketing', api_base_urls
  subject { described_class.new(params: params).execute }

  describe 'without arguments' do
    let(:params) { nil }
    it { is_expected.to have_exactly(507).items }
  end

  describe 'validations' do
    context 'too many arguments' do
      let(:params) { 'too_many_arguments' }
      it { expect { subject }.to raise_error(Query::ArgumentError) }
    end
  end

  describe 'query fields' do
    let(:params) { nil }
    it_behaves_like 'query fields'
  end
end
