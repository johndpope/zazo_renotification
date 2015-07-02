class Setting < ActiveRecord::Base
  validates :started, inclusion: [true, false]
  validates :type, presence: true, uniqueness: true
end
