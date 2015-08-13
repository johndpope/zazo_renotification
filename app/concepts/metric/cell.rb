class Metric::Cell < Cell::Concept
  include Chartkick::Helper

  layout :layout
  property :type
  property :name

  def show
    render '_' + type.to_s
  rescue Cell::TemplateMissingError
    render :show
  end

  private

  #
  # shared for metric view
  #

  def title
    name.demodulize.titleize
  end

  def chart(options = {})
    send type, options
  end

  def chart_id
    "chart-#{SecureRandom.hex}"
  end

  def data
    if options[:program_id]
      model.new(program_id: options[:program_id]).execute
    else
      model.new.execute
    end
  end

  #
  # shared for layout view
  #

  def program_links
    content_tag :span do
      links = Program.all.collect do |prg|
        link_to(prg.name, "?metrics_by_program=#{prg.id}", class: "#{prg.id == options[:program_id].to_i ? 'active' : ''}")
      end
      ([link_to('all', '?', class: "#{options[:program_id] ? '' : 'active'}")] + links).join(' ')
    end
  end
end
