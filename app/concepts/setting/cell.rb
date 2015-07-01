class Setting::Cell < Cell::Concept
  include ActionView::RecordIdentifier
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormOptionsHelper
  include SimpleForm::ActionViewExtensions::FormHelper

  class Entity < Cell::Concept
    def edit(type)
      klass = "#{type.to_s}::Setting".classify.constantize
      concept('setting/cell', klass.first).edit
    end
  end

  def edit
    render :edit
  end
end
