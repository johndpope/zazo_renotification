class Template::Compiler
  def initialize(template)
    @template = template
  end

  def preview
    data  = preview_data
    title = ERB.new(@template.title).result data
    body  = ERB.new(@template.body).result  data
    "#{title} #{body}"
  end

  def compile
    'will be soon'
  end

  private

  def preview_data
    inviter_name = 'Sani'
    days_ago     = 6
    app_link     = 'http://zazoapp.com/'
    binding
  end
end
