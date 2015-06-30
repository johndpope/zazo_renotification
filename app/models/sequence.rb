class Sequence < ActiveRecord::Base
  attr_accessor :type

  belongs_to :template

  scope :by_template_type, -> (type) { joins(:template).where 'templates.kind' => type }

  validates :delay_hours, presence: true
  validates :template, presence: true
end
