class Sequence::Cell < Cell::Concept
  include ActionView::RecordIdentifier
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormOptionsHelper
  include SimpleForm::ActionViewExtensions::FormHelper
  include FontAwesome::Rails::IconHelper

  property :template, :delay_hours

  def show
    render :show
  end

  def new
    render :new
  end

  private

  def templates
    Template.where(kind: model.type).all
  end

  def description
    delay = content_tag :b, "#{delay_hours} h."
    name  = content_tag :b, template.name
    "Send after [#{delay}] with [#{name}] template"
  end

  def remove_button
    link_to fa_icon('trash-o'), model,
            data: { confirm: 'Are you sure?' },
            method: :delete, class: 'pull-right'
  end
end
