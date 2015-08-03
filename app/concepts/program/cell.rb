class Program::Cell < Cell::Concept
  include ActionView::RecordIdentifier
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormOptionsHelper
  include SimpleForm::ActionViewExtensions::FormHelper
  include ActionView::Helpers::CaptureHelper

  property :id, :name

  def show
    render :show
  end

  def new
    render :form
  end

  def edit
    render :form
  end

  private

  def status
    model.setting.started ? '[active]' : '[inactive]'
  end

  def queries
    with_prefix :queries, (model.queries.map do |query|
      "#{query.type.split('::').last} => \"#{query.params}\""
    end.join(', '))
  end

  def conditions
    with_prefix :conditions, (model.conditions.pluck(:type).map do |type|
      type.split('::').last
    end.join(', '))
  end

  def with_prefix(prefix, data)
    prefix = content_tag :b, prefix.to_s.capitalize
    "#{prefix}: [#{data}]"
  end
end
