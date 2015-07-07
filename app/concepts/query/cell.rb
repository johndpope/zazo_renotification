class Query::Cell < Cell::Concept
  def show
    render
  end

  private

  def name
    model.name
  end

  def results
    @results ||= model.new.execute
  end

  def parse_time(string)
    Time.parse string
  end
end
