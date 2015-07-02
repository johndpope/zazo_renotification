require 'rails_helper'

RSpec.describe Setting, type: :model do
  describe 'validations' do
    it { is_expected.to validate_uniqueness_of :type }
    it { is_expected.to validate_presence_of :type }
  end
end
