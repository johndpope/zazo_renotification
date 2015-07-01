require 'rails_helper'

RSpec.describe Template, type: :model do
  describe 'validations' do
    it { is_expected.to validate_inclusion_of(:kind).in_array(%w(ios android sms email)) }

    context 'template syntax' do
      it 'fails with invalid title' do
        template = FactoryGirl.build :sms_template, title: '<%= 1+2.to_s %>'
        template.valid?
        expect(template.errors[:title].size).to eq(1)
        expect(template.errors[:title][0]).to eq('String can\'t be coerced into Fixnum')
      end

      it 'fails with invalid body' do
        template = FactoryGirl.build :sms_template, body: '<%= not_exist %>'
        template.valid?
        expect(template.errors[:body].size).to eq(1)
        expect(template.errors[:body][0]).to include('undefined local variable or method')
      end
    end

    it 'success with valid params' do
      template = FactoryGirl.build :sms_template
      expect(template).to be_valid
    end
  end
end
