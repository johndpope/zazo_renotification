class Program < ActiveRecord::Base
  acts_as_paranoid

  has_one  :setting
  has_many :queries
  has_many :conditions
  has_many :sequences

  after_create  :set_setting
  after_destroy :set_name_prefix

  validates :name, presence: true

  scope :order_by_updated_at, -> { order updated_at: :desc }
  scope :active, -> { joins(:setting).where settings: { started: true } }

  def grouped_sequences
    Template::ALLOWED_TYPES.each_with_object({}) do |type, memo|
      memo[type] = self.sequences.by_template_type(type).order_by_delay
    end
  end

  private

  def set_name_prefix
    update_attributes name: "#{self.name} [deleted]"
  end

  def set_setting
    Setting.create started: false, program: self
  end
end
