require 'rails_helper'

RSpec.describe Manage::Message do
  use_vcr_cassette 'queries/not_verified', api_base_urls
  let(:program)   { FactoryGirl.create :program_with_templates }
  let(:user_data) { Query::NotVerified.new.execute.first }

  describe 'when time_zero' do
    let(:data) do
      u_data = user_data.clone
      u_data['time_zero'] = time_zero
      UserData.new u_data
    end

    subject do
      described_class.new({
        data: data,
        program: program,
        delayed_template: program.delayed_templates.first
      }).time_zero
    end

    context 'is too old' do
      let(:time_zero) { Time.now - 30.days }
      it { is_expected.to be_within(1.second).of Time.now }
    end

    context 'is nearly new' do
      let(:time_zero) { Time.now - 30.minutes }
      it { is_expected.to eq(time_zero) }
    end
  end

  describe '.create' do
    let(:data) { UserData.new user_data }

    before do
      real_time_zero = nil
      program.delayed_templates.each do |dt|
        manager = described_class.new data: data, time_zero: real_time_zero,
                                      program: program, delayed_template: dt
        manager.create
        real_time_zero = manager.time_zero
      end
    end

    it 'saved messages into database' do
      expect(Message.where program: program).to have(2).items
    end
  end
end
