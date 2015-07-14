require 'rails_helper'

RSpec.describe DelayedTemplate, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :delay_hours }
    it { is_expected.to validate_presence_of :template }
    it { is_expected.to validate_presence_of :program }
    it { is_expected.to validate_numericality_of :delay_hours }

    it 'fails with invalid params' do
      delayed_template = FactoryGirl.build :delayed_template
      expect(delayed_template).to be_invalid
    end

    it 'success with valid params' do
      delayed_template = FactoryGirl.build :sms_delayed_template
      expect(delayed_template).to be_valid
    end
  end
end
