require 'rails_helper'

RSpec.describe Program::Execute do
  let(:program) { FactoryGirl.create :program_with_dependencies }
  subject { described_class.new program }

  describe '.do' do
    use_vcr_cassette 'queries/not_verified', api_base_urls
    use_vcr_cassette 'queries/non_marketing', api_base_urls
    before { subject.do }
    let(:messages) { Message.where program_id: program.id }

    it 'creates two messages for each user' do
      expect(messages).to have_exactly(120).items
    end

    it 'creates messages need to be sent after 1 hour' do
      after_1_hours = messages.where 'send_at < ?', Time.now + 61.minutes
      expect(after_1_hours).to have_exactly(60).items
    end

    it 'creates messages need to be sent after 2 hour' do
      after_2_hours = messages.where 'send_at > ?', Time.now + 119.minutes
      expect(after_2_hours).to have_exactly(60).items
    end
  end
end
