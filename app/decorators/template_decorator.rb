class TemplateDecorator < Draper::Decorator
  delegate_all

  def title
    object.title
  end

  def body
    object.body
  end

  def preview
    'will be soon'
  end
end
