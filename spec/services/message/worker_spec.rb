require 'rails_helper'

RSpec.describe Message::Worker do
  use_vcr_cassette 'queries/not_verified',     api_base_urls
  use_vcr_cassette 'queries/non_marketing',    api_base_urls
  use_vcr_cassette 'attributes/mobile_number', api_base_urls

  let(:program)  { FactoryGirl.create :program_with_dependencies }
  let(:sent_messages) { Message.where(program: program).where(status: :sent) }

  describe '.execute' do
    before do
      Program::Execute.new(program).do
      allow_any_instance_of(Message::SendSms).to receive(:mobile_number).and_return 'xxxxxxxxxxx'
    end

    context 'after 1 hour' do
      before { Timecop.travel(Time.now + 1.hours) { described_class.execute } }
      it { expect(sent_messages).to have_exactly(1363).items }
    end

    context 'after 2 hours' do
      before { Timecop.travel(Time.now + 2.hours) { described_class.execute } }
      it { expect(sent_messages).to have_exactly(2726).items }
    end
  end
end
