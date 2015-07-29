class Program::Execute
  attr_reader :program, :users, :delayed_templates

  def initialize(program)
    @program = program
    @users   = Query::Intersection.new(program.queries).results
    @delayed_templates = program.grouped_delayed_templates
  end

  def do
    users.each do |data|
      user_data = UserData.new data
      create_messages user_data if messages_not_persisted? user_data.user.mkey
    end
  end

  private

  def create_messages(data)
    delayed_templates.keys.each do |type|
      real_time_zero = nil
      delayed_templates[type].each do |dt|
        manager = Manage::Message.new data: data, time_zero: real_time_zero,
                                      program: program, delayed_template: dt
        manager.create
        real_time_zero = manager.time_zero
      end
    end
  end

  def messages_not_persisted?(user)
    Message.in_progress_by_target(user).empty? &&
    Message.by_target_program(user, program).empty?
  end
end
