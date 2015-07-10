class Program < ActiveRecord::Base
  has_one  :setting,    dependent: :destroy
  has_many :queries,    dependent: :destroy
  has_many :conditions, dependent: :destroy
  has_many :sequences,  dependent: :destroy

  after_create :set_setting

  validates :name, presence: true, uniqueness: true

  scope :order_by_updated_at, -> { order updated_at: :desc }
  scope :active, -> { joins(:setting).where settings: { started: false } }

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
