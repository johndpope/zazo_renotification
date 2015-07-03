class Condition < ActiveRecord::Base
  CONDITIONS = %i(not_verified).freeze

  belongs_to :program

  validates :type, presence: true
  validates :program, presence: true

  def check
    # Redefine this method in the inherited class
  end
end
