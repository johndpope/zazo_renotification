class Template::Cell < Cell::Concept
  include ActionView::Helpers::CaptureHelper

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

  def preview
    ::Template::Compiler.new(model).preview
  end
end
