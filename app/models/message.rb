class Message < ActiveRecord::Base
  ALLOWED_STATUSES = %w{sent canceled error}.freeze

  belongs_to :program, -> { with_deleted }
  belongs_to :delayed_template

  validates :target, :body, :send_at, :program, :delayed_template, presence: true
  validates :status, inclusion: { in: ALLOWED_STATUSES, message: '%{value} is not a valid status' }, allow_nil: true

  scope :in_progress,           -> { where status: nil }
  scope :by_target,             -> (target) { where target: target }
  scope :in_progress_by_target, -> (target) { in_progress.by_target(target) }
  scope :by_target_program,     -> (target, program) { by_target(target).where(program: program) }
  scope :time_passed,           -> { in_progress.where('send_at < ?', Time.now) }

  scope :in_queue, -> { where status: nil }
  scope :sent,     -> { where status: :sent }
  scope :canceled, -> { where status: :canceled }
  scope :error,    -> { where status: :error }

  def kind
    delayed_template.template.kind
  end

  def order
    current_dt_id = delayed_template.id
    program.delayed_templates.order_by_delay.index do |dt|
      dt.id == current_dt_id
    end + 1
  end
end
