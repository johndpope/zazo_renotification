class Program < ActiveRecord::Base
  has_one  :setting
  has_many :queries
  has_many :conditions
  has_many :sequences

  after_create :set_setting

  validates :name, presence: true, uniqueness: true

  private

  def set_setting
    Setting.create started: false, program: self
  end
end
