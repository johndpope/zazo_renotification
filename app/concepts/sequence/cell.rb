class Sequence::Cell < Cell::Concept
  include ActionView::RecordIdentifier
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormOptionsHelper
  include SimpleForm::ActionViewExtensions::FormHelper
  include FontAwesome::Rails::IconHelper

  class Program < Cell::Concept
    property :name

    def show
      @sequences = model.grouped_sequences
      @sequences.keys.each do |type|
        @sequences.delete(type) unless @options[:types].include? type.to_sym
      end
      render :show
    end

    def edit(options)
      @sequence  = options[:sequence]
      @sequences = model.sequences.by_template_type(@sequence.type).order_by_delay
      @templates = Template.by_type @sequence.type
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

  def remove_button
    return '' unless @options[:allow_destroy]
    link_to fa_icon('trash-o'), [model.program, model],
            data: { confirm: 'Are you sure?' },
            method: :delete, class: 'pull-right'
  end
end
