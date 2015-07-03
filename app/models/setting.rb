class Setting < ActiveRecord::Base
  belongs_to :program

  validates :started, inclusion: [true, false]
  validates :program, presence: true, uniqueness: true
end
