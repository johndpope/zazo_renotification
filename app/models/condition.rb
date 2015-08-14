class Condition < ActiveRecord::Base
  CONDITIONS = %i(not_verified).freeze

  belongs_to :program

  validates :type, presence: true
  validates :program, presence: true

  def self.nested
    CONDITIONS.map do |key|
      Classifier.new([:condition, key]).klass
    end
  end
end
