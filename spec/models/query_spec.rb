require 'rails_helper'

RSpec.describe Query, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :type }
    it { is_expected.to validate_presence_of :program }
  end

  describe '.nested' do
    subject { described_class.nested }
    let(:nested_queries) do
      [ Query::NotVerified,
        Query::NonMarketing,
        Query::SpecificUsers ]
    end
    it { is_expected.to contain_exactly(*nested_queries) }
  end
end
