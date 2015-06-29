class TemplateDecorator < Draper::Decorator
  delegate_all

  def title
    prefix = h.content_tag :b, 'Title'
    if object.title.size > 0
      "#{prefix}: #{object.title}"
    else
      "#{prefix} not presented"
    end
  end

  def body
    prefix = h.content_tag :b, 'Body'
    "#{prefix}: #{object.body}"
  end

  def preview
    ::Template::Compiler.new(object).preview
  end
end
