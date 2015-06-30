class Sequence::Cell < Cell::Concept
  include ActionView::RecordIdentifier
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormOptionsHelper
  include SimpleForm::ActionViewExtensions::FormHelper

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
end
