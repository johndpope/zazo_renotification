class Template::Compiler
  attr_reader :template

  def initialize(template)
    @template = template
  end

  def title(data = nil)
    data = @data if data.nil?
    ERB.new(template.title).result data
  end

  def body(data = nil)
    data = @data if data.nil?
    ERB.new(template.body).result data
  end

  def preview
    data = preview_data
    "#{title data} #{body data}"
  end

  def validate(key)
    send key, preview_data
    return true
  rescue => e
    return false, e.message
  end

  def compile(params)
    mkey      = params['mkey']
    user      = params['user']
    friend    = params['friend']
    time_zero = params['time_zero']
    @data     = binding
  end

  private

  def preview_data
    mkey      = SecureRandom.hex
    user      = 'David Gilmour'
    friend    = 'Syd Barrett'
    time_zero = '1967-12-22 15:00:00 UTC'
    binding
  end
end
