class Program::Execute
  attr_reader :program, :users, :sequences

  def initialize(program)
    @program   = program
    @sequences = program.grouped_sequences
    @users     = Query::Intersection.new(program.queries).results
  end

  def do
    users.each { |user_data| create_messages user_data }
    # TODO: reduce users already in messages queue
  end

  private

  def create_messages(data)
    sequences.keys.each do |type|
      real_time_zero = nil
      sequences[type].each do |seq|
        manager = Manage::Message.new data: data, time_zero: real_time_zero,
                                      program: program, sequence: seq
        message = manager.create
        real_time_zero = manager.time_zero
        Message::Send.new(message).later
      end
    end
  end
end
