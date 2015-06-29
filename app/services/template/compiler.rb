class Template::Compiler
  def initialize(template)
    @template = template
  end

  def title(data)
    ERB.new(@template.title).result data
  end

  def body(data)
    ERB.new(@template.body).result data
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

  def compile
    'will be soon'
  end

  private

  def preview_data
    inviter  = 'Sani'
    days_ago = 6
    app_link = 'http://zazoapp.com/'
    binding
  end
end
