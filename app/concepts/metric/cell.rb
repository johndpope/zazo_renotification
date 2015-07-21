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
    model.new.execute
  end
end
