class Query < ActiveRecord::Base
  validates :type, presence: true, uniqueness: true

  scope :by_type, -> (type) { where 'type LIKE ?', type + '%' }

  def execute
    # Redefine this method in the inherited class
  end
end
