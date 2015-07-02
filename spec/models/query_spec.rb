require 'rails_helper'

RSpec.describe Query, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :type }
    it { is_expected.to validate_uniqueness_of :type }
  end
end
