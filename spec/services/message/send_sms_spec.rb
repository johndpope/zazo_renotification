require 'rails_helper'

RSpec.describe Message::SendSms do
  let(:instance) { described_class.new *params }
  subject        { instance.do options }

  describe '.do without forcing' do
    let(:options) { {} }

    context 'with specific user mobile' do
      use_vcr_cassette 'queries/not_verified', api_base_urls
      use_vcr_cassette 'attributes/mobile_number', api_base_urls
      let(:user_data) { Query::NotVerified.new.execute.first }
      let(:message) do
        program = FactoryGirl.create :program_with_templates
        Manage::Message.new(
          data: UserData.new(user_data),
          program: program,
          delayed_template: program.delayed_templates.first
        ).build
      end
      let(:params) { [message] }

      it { is_expected.to eq(true) }
      it { expect(instance.mobile).to eq(:none) } #eq('+380919614028') }
    end

    context 'with custom mobile' do
      let(:params) { [FactoryGirl.build(:message), '+79109767407'] }

      context 'with production env' do
        use_vcr_cassette 'services/message/send_sms_custom_mobile', api_base_urls
        it do
          allow(Rails).to receive(:env).and_return ActiveSupport::StringInquirer.new('production')
          is_expected.to eq(true)
        end
      end

      context 'with test env' do
        it { is_expected.to eq(true) }
      end
    end
  end

  describe '.do with forcing' do
    let(:options) { { force: true } }
    let(:message) { FactoryGirl.build :message }

    context 'with incorrect mobile' do
      use_vcr_cassette 'services/message/send_sms_incorrect_mobile', api_base_urls
      let(:params) { [message, 'xxxxxxxxxxx'] }
      it { is_expected.to eq(false) }
    end

    context 'with correct custom mobile' do
      use_vcr_cassette 'services/message/send_sms_custom_mobile', api_base_urls
      let(:params) { [message, '+79109767407'] }
      it { is_expected.to eq(true) }
    end
  end
end
