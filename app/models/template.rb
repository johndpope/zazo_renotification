class Template < ActiveRecord::Base
  ALLOWED_TYPES = %w(sms email ios android).freeze

  acts_as_paranoid

  has_many :delayed_templates
  has_many :localized_templates

  after_destroy :set_name_prefix

  scope :by_type, -> (type) { where kind: type }
  scope :order_by_updated_at, -> { order updated_at: :desc }

  validates :kind, presence: true, inclusion: { in: ALLOWED_TYPES, message: "%{value} is not a valid type" }
  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :body, presence: true
  validates_with SyntaxValidator

  private

  def set_name_prefix
    update_attributes name: "#{self.name} [deleted]"
  end
end
