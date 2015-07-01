class Sequence < ActiveRecord::Base
  attr_accessor :type

  belongs_to :template

  scope :by_template_type, -> (type) { joins(:template).where 'templates.kind' => type }
  scope :order_by_delay, -> { order :delay_hours }

  validates :delay_hours, presence: true
  validates :template, presence: true
end
