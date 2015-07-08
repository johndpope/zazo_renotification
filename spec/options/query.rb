require 'rails_helper'

RSpec.describe Query, type: :model do
  describe '.nested' do
    subject { described_class.nested }
    let(:nested_queries) do
      [Query::NotVerified]
    end
    it { is_expected.to eq(nested_queries) }
  end
end
