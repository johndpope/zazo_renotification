class Query < ActiveRecord::Base
  QUERIES = %i(not_verified).freeze

  module Api
    def execute
      # Redefine this method in the extended class
    end
  end

  belongs_to :program

  validates :type, presence: true
  validates :program, presence: true

  scope :by_type, -> (type) { where 'type LIKE ?', type + '%' }

  def self.nested
    descendants.select { |klass| klass.name.starts_with?("#{name}::") }.sort_by(&:name)
  end
end
