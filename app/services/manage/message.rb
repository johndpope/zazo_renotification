class Manage::Message
  attr_reader :data, :program, :delayed_template, :time_zero

  def initialize(options)
    @delayed_template = options[:delayed_template]
    @data      = options[:data]
    @program   = options[:program]
    @time_zero = init_time_zero options[:time_zero]
    @compiler  = Template::Compiler.new delayed_template.template
    @compiler.compile data
  end

  def create
    Message.create(
      target:   data.mkey,
      title:    @compiler.title,
      body:     @compiler.body,
      send_at:  time_zero + delayed_template.delay_hours.hours,
      program:  program,
      delayed_template: delayed_template
    )
  end

  private

  def init_time_zero(from_params)
    return from_params unless from_params.nil?
    from_data = data.time_zero
    next_time = from_data + delayed_template.delay_hours.hours
    Time.now < next_time ? from_data : Time.now
  end
end
