class Query < ActiveRecord::Base
  class ArgumentError < StandardError; end

  QUERIES = %i(not_verified non_marketing).freeze

  belongs_to :program

  validates :type, presence: true
  validates :program, presence: true

  scope :by_type, -> (type) { where 'type LIKE ?', type + '%' }

  def self.nested
    descendants.select do |klass|
      klass.name.starts_with? "#{name}::"
    end.sort_by(&:name)
  end
end
