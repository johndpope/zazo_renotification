require 'rails_helper'

RSpec.describe Message::Worker do
  use_vcr_cassette 'queries/not_verified',  api_base_urls
  use_vcr_cassette 'queries/non_marketing', api_base_urls

  let(:program)  { FactoryGirl.create :program_with_dependencies }
  let(:messages) { Message.where(program: program).where(status: :sent) }
  before { Program::Execute.new(program).do }

  describe '.execute after 1 hour' do
    before do
      Timecop.travel(Time.now + 1.hours) { described_class.execute }
    end
    it { expect(messages).to have_exactly(60).items }
  end

  describe '.execute after 2 hours' do
    before do
      Timecop.travel(Time.now + 2.hours) { described_class.execute }
    end
    it { expect(messages).to have_exactly(120).items }
  end
end
