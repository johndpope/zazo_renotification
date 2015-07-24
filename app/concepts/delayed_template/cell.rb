class DelayedTemplate::Cell < Cell::Concept
  include ActionView::RecordIdentifier
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormOptionsHelper
  include SimpleForm::ActionViewExtensions::FormHelper
  include FontAwesome::Rails::IconHelper

  class Program < Cell::Concept
    property :name

    def show
      @delayed_templates = model.grouped_delayed_templates
      @delayed_templates.keys.each do |type|
        @delayed_templates.delete(type) unless @options[:types].include? type.to_sym
      end
      render :show
    end

    def edit(options)
      @delayed_template  = options[:delayed_template]
      @delayed_templates = model.delayed_templates.by_template_type(@delayed_template.type).order_by_delay
      @templates = Template.by_type @delayed_template.type
      render :edit
    end
  end

  property :template, :delay_hours

  def initialize(*)
    super
    @options[:allow_destroy] = true if @options[:allow_destroy].nil?
  end

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

  def preview_template
    Template::Compiler.new(template).preview
  end

  def remove_button
    return '' unless @options[:allow_destroy]
    link_to fa_icon('trash-o'), [model.program, model],
            data: { confirm: 'Are you sure?' }, method: :delete
  end
end
