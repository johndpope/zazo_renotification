class Condition < ActiveRecord::Base
  module Api
    def check
      # Redefine this method in the extended class
    end
  end

  CONDITIONS = %i(not_verified).freeze

  belongs_to :program

  validates :type, presence: true
  validates :program, presence: true
end
