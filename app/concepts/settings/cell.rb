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
      queries = Query::QUERIES.map { |q| q.to_s.camelize }
      by_program = model.queries.pluck(:type, :params).map { |q| [q[0].split('::').last, q[1]] }
      active = by_program.map &:first
      params = by_program.each_with_object({}) { |query, memo| memo[query[0]] = query[1] }
      concept('settings/cell', queries).queries program: model, active: active, params: params
    end

    def render_conditions
      conditions = Condition::CONDITIONS.map { |q| q.to_s.camelize }
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
    @params  = options[:params] || {}
  end
end
