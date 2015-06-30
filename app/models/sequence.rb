class Sequence < ActiveRecord::Base
  attr_accessor :type

  belongs_to :template

  validates :delay_hours, presence: true
  validates :template_id, presence: true
end
