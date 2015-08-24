require 'rails_helper'

RSpec.describe Template, type: :model do
  describe 'validations' do
    let(:template_incorrect_title) { FactoryGirl.build :sms_template, title: '<%= 1+2.to_s %>' }
    let(:template_incorrect_body)  { FactoryGirl.build :sms_template, body: '<%= not_exist %>' }

    it { is_expected.to validate_inclusion_of(:kind).in_array(%w(ios android sms email)) }
    it_behaves_like 'template syntax validations'

    it 'success with valid params' do
      template = FactoryGirl.build :sms_template
      expect(template).to be_valid
    end
  end
end
