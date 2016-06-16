class Template::Compiler
  attr_reader :template

  def initialize(template)
    @template = template
  end

  def title
    ERB.new(template.title).result(@data).squish
  end

  def body
    ERB.new(template.body).result(@data).squish
  end

  def preview
    compile(preview_data)
    "#{title} #{body}"
  end

  def validate(key)
    compile(preview_data)
    send key
    return true
  rescue => e
    return false, e.message
  end

  def compile(user_data)
    @data = user_data.bind
  end

  private

  def preview_data
    UserData.new(
      id: 1967,
      mkey: :preview,
      user: 'David Gilmour',
      friend: 'Syd Barrett',
      time_zero: '1967-12-22 15:00:00 UTC',
      connection_id: 2015)
  end
end
