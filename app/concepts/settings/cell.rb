class Settings::Cell < Cell::Concept
  include ActionView::RecordIdentifier
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormOptionsHelper
  include SimpleForm::ActionViewExtensions::FormHelper

  class Program < Cell::Concept
    def edit
      components = {
        main: render_main,
        queries: render_queries,
        conditions: render_conditions
      }
      concept('settings/cell', components).edit
    end

    private

    def render_main
      concept('settings/cell', model.setting).main
    end

    def render_queries
      queries = Query::QUERIES.map { |q| q.to_s.classify }
      active = model.queries.pluck(:type).map { |q| q.split('::').last }
      concept('settings/cell', queries).queries program: model, active: active
    end

    def render_conditions
      conditions = Condition::CONDITIONS.map { |q| q.to_s.classify }
      active = model.conditions.pluck(:type).map { |q| q.split('::').last }
      concept('settings/cell', conditions).conditions program: model, active: active
    end
  end

  def edit
    render :edit
  end

  def main
    render :main
  end

  def queries(options)
    set_options options
    render :queries
  end

  def conditions(options)
    set_options options
    render :conditions
  end

  def set_options(options)
    @active  = options[:active]
    @program = options[:program]
  end
end
