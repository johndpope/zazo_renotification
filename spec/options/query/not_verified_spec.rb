require 'rails_helper'

RSpec.describe Query::NotVerified, type: :model do
  use_vcr_cassette 'queries/not_verified', api_base_urls
  let(:instance) { described_class.new params: params }
  subject { instance.execute }

  describe 'with arguments' do
    context 'default' do
      let(:params) { nil }
      it { is_expected.to have_exactly(2984).items }
    end

    context '2015-07-01 00:00 with passing' do
      let(:params) { '2015-07-01 00:00' }
      it { is_expected.to have_exactly(1208).items }
    end

    context '2015-07-01 00:00 without passing' do
      let(:params) { nil }
      let(:selected) do
        subject.select do |row|
          time_zero   = Time.parse row['time_zero']
          time_reduce = Time.parse '2015-07-01 00:00'
          time_zero > time_reduce
        end
      end

      it { expect(selected).to have_exactly(1208).items }
    end
  end

  describe 'validations' do
    context 'too many arguments' do
      let(:params) { 'first,second' }
      it { expect { subject }.to raise_error(Query::ArgumentError) }
    end

    context 'incorrect arguments' do
      let(:params) { 'incorrect' }
      it { expect { subject }.to raise_error(Query::ArgumentError) }
    end
  end

  describe 'query fields' do
    let(:params) { nil }
    it_behaves_like 'query fields'
  end
end
