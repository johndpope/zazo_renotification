class Template < ActiveRecord::Base
  ALLOW_TYPES = %w(sms email ios android).freeze

  validates :kind, presence: true, inclusion: { in: ALLOW_TYPES, message: "%{value} is not a valid type" }
  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :body, presence: true
end
