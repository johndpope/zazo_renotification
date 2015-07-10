class Message < ActiveRecord::Base
  belongs_to :program
  belongs_to :sequence

  validates :target, :body, :send_at, :program, :sequence, presence: true
end
