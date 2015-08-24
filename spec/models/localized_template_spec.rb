require 'rails_helper'

RSpec.describe LocalizedTemplate, type: :model do
  describe 'validations' do
    let(:template_incorrect_title) { FactoryGirl.build :localized_template, title: '<%= 1+2.to_s %>' }
    let(:template_incorrect_body)  { FactoryGirl.build :localized_template, body: '<%= not_exist %>' }

    it { is_expected.to validate_presence_of :body }
    it { is_expected.to validate_presence_of :locale }
    it { is_expected.to validate_presence_of :template }
    it { is_expected.to validate_inclusion_of(:locale).in_array(%w(russian)) }
    it_behaves_like 'template syntax validations'

    context 'unique locale validation' do
      let!(:parent) { FactoryGirl.create :template_localized }
      let(:child) { FactoryGirl.build :localized_template, template: parent }

      it 'fails with already persisted locale' do
        child.valid?
        expect(child.errors[:locale].size).to eq(1)
        expect(child.errors[:locale][0]).to include('template with russian locale already exist')
      end
    end
  end
end
