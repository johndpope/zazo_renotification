class Condition < ActiveRecord::Base
  validates :type, presence: true, uniqueness: true

  scope :by_type, -> (type) { where 'type LIKE ?', type + '%' }

  def check
    # Redefine this method in the inherited class
  end
end
