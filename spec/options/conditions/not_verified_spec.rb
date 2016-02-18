require 'rails_helper'

RSpec.describe Condition::NotVerified, type: :model do
  use_vcr_cassette 'queries/not_verified', api_base_urls
  let(:instance) { described_class.new }

  describe '#check' do
    subject { instance.check(user) }

    context 'not verified user' do
      use_vcr_cassette 'conditions/not_verified_true', api_base_urls
      let(:user) { Query::NotVerified.new.execute.first['mkey'] }
      it { is_expected.to eq true }
    end

    context 'non existent user' do
      use_vcr_cassette 'conditions/not_verified_false', api_base_urls
      let(:user) { 'xxxxxxxxxxxxxxxxxxxx' }
      it { is_expected.to eq false }
    end
  end
end
