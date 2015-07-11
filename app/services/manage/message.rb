class Manage::Message
  attr_reader :data, :program, :sequence, :time_zero

  def initialize(options)
    @data      = options[:data]
    @sequence  = options[:sequence]
    @program   = options[:program]
    @time_zero = init_time_zero options[:time_zero]
    @compiler  = Template::Compiler.new @sequence.template
    @compiler.compile data
  end

  def create
    Message.create(
      target:   data['mkey'],
      title:    @compiler.title,
      body:     @compiler.body,
      send_at:  time_zero + sequence.delay_hours.hours,
      program:  program,
      sequence: sequence
    )
  end

  private

  def init_time_zero(from_params)
    return from_params unless from_params.nil?
    from_data = Time.parse data['time_zero']
    next_time = from_data + sequence.delay_hours.hours
    Time.now < next_time ? from_data : Time.now
  end
end
