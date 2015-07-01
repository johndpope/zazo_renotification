class Setting < ActiveRecord::Base
  validates :started, inclusion: [true, false]
  validates :type, uniqueness: true
end
