class Template::Cell < Cell::Concept
  include ActionView::Helpers::CaptureHelper

  class Localized < Cell::Concept
    property :locale, :title, :body

    def show
      render
    end

    private

    def field(method)
      prefix = content_tag :b, method.capitalize
      content_tag :p, "#{prefix}: #{send method}"
    end

    def preview
      template = Template.new title: title, body: body
      ::Template::Compiler.new(template).preview
    end
  end

  property :id, :kind, :name

  def initialize(*)
    super
    @options[:allow_destroy] = true if @options[:allow_destroy].nil?
  end

  def show
    render :show
  end

  private

  def title
    prefix = content_tag :b, 'Title'
    if model.title.size > 0
      "#{prefix}: #{model.title}"
    else
      "#{prefix} not presented"
    end
  end

  def body
    prefix = content_tag :b, 'Body'
    "#{prefix}: #{model.body}"
  end

  def localized
    model.localized_templates
  end

  def preview
    ::Template::Compiler.new(model).preview
  end
end
