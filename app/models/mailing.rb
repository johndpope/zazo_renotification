class Mailing < ActiveRecord::Base
  ALLOWED_STATUSES = %w(success fail)

  validates :status, presence: true, inclusion: { in: ALLOWED_STATUSES, message: '%{value} is not a valid status' }
  validates :message, :phone, :key, presence: true

  scope :by_key, -> (key) { where key: key }
end
