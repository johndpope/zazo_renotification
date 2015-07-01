require 'rails_helper'

RSpec.describe Sequence, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :delay_hours }
    it { is_expected.to validate_presence_of :template }
    it { is_expected.to validate_numericality_of :delay_hours }

    it 'fails with invalid params' do
      sequence = FactoryGirl.build :sequence
      expect(sequence).to be_invalid
    end

    it 'success with valid params' do
      sequence = FactoryGirl.build :sms_sequence
      expect(sequence).to be_valid
    end
  end
end
