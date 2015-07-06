class Query < ActiveRecord::Base
  QUERIES = %i(not_verified).freeze

  module Api
    def events_api
      EventsApi.new
    end

    def execute
      # Redefine this method in the extended class
    end
  end

  belongs_to :program

  validates :type, presence: true
  validates :program, presence: true

  scope :by_type, -> (type) { where 'type LIKE ?', type + '%' }
end
