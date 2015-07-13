class Condition < ActiveRecord::Base
  CONDITIONS = %i(not_verified).freeze

  belongs_to :program

  validates :type, presence: true
  validates :program, presence: true
end
