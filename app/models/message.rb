class Message < ActiveRecord::Base
  belongs_to :program
  belongs_to :sequence

  validates :target, :body, :send_at, :program, :sequence, presence: true

  scope :in_progress_by_target, -> (target) { where(target: target).where(is_sent: nil) }
end
