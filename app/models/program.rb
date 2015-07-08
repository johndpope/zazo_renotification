class Program < ActiveRecord::Base
  has_one  :setting
  has_many :queries
  has_many :conditions
  has_many :sequences

  after_create :set_setting

  validates :name, presence: true, uniqueness: true

  scope :order_by_updated_at, -> { order updated_at: :desc }

  def grouped_sequences
    (Template::ALLOW_TYPES).each_with_object({}) do |type, memo|
      memo[type] = self.sequences.by_template_type(type).order_by_delay
    end
  end

  private

  def set_setting
    Setting.create started: false, program: self
  end
end
