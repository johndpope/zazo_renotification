class Settings::Cell < Cell::Concept
  include ActionView::RecordIdentifier
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormOptionsHelper
  include SimpleForm::ActionViewExtensions::FormHelper

  class Entity < Cell::Concept
    def edit(type)
      components = {
        main: render_main(type),
        queries: render_queries(type),
        conditions: render_conditions(type)
      }
      concept('settings/cell', components).edit
    end

    private

    def render_main(type)
      klass = Classifier.new([type, :setting]).klass
      concept('settings/cell', klass.first).main
    end

    def render_queries(type)
      queries = Classifier.new([type, :query]).klass::QUERIES.map { |q| q.to_s.classify }
      active = Query.by_type(type.to_s.classify).pluck(:type).map { |q| q.split('::').last }
      concept('settings/cell', queries).queries type: type, active: active
    end

    def render_conditions(type)
      concept('settings/cell', []).conditions type: type
    end
  end

  def edit
    render :edit
  end

  def main
    render :main
  end

  def queries(options)
    @type   = options[:type]
    @active = options[:active]
    render :queries
  end

  def conditions(options)
    render :conditions
  end
end
