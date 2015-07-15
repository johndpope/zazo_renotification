class Message < ActiveRecord::Base
  ALLOWED_STATUSES = %w{sent canceled}

  belongs_to :program
  belongs_to :delayed_template

  validates :target, :body, :send_at, :program, :delayed_template, presence: true
  validates :status, inclusion: { in: ALLOWED_STATUSES, message: "%{value} is not a valid status" }, allow_nil: true

  scope :in_progress_by_target, -> (target) { where(target: target).where(status: nil) }
  scope :time_passed, -> { where(status: nil).where('send_at < ?', Time.now) }

  scope :in_queue, -> { where status: nil }
  scope :sent,     -> { where status: :sent }
  scope :canceled, -> { where status: :canceled }
end
