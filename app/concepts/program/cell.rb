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
    render :new
  end

  def edit
    render :edit
  end

  private

  def status
    model.setting.started ? '[active]' : '[inactive]'
  end

  def queries
    join_relations :queries
  end

  def conditions
    join_relations :conditions
  end

  def join_relations(key)
    joined = model.send(key).pluck(:type).map do |type|
      type.split('::').last
    end.join(', ')
    prefix = content_tag :b, key.to_s.capitalize
    "#{prefix}: [#{joined}]"
  end
end
