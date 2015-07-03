class Query < ActiveRecord::Base
  QUERIES = %i(not_verified).freeze

  belongs_to :program

  validates :type, presence: true
  validates :program, presence: true

  scope :by_type, -> (type) { where 'type LIKE ?', type + '%' }

  def execute
    # Redefine this method in the inherited class
  end
end
