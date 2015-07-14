class Program::Execute
  attr_reader :program, :users, :delayed_templates

  def initialize(program)
    @program   = program
    @users     = Query::Intersection.new(program.queries).results
    @delayed_templates = program.grouped_delayed_templates
  end

  def do
    users.each do |data|
      create_messages data if Message.in_progress_by_target(data['mkey']).empty?
    end
  end

  private

  def create_messages(data)
    delayed_templates.keys.each do |type|
      real_time_zero = nil
      delayed_templates[type].each do |dt|
        manager = Manage::Message.new data: data, time_zero: real_time_zero,
                                      program: program, delayed_template: dt
        message = manager.create
        real_time_zero = manager.time_zero
        Message::Send.new(message).later
      end
    end
  end
end
