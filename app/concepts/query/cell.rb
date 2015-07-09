class Query::Cell < Cell::Concept
  def show
    render
  end

  private

  def parse_time(string)
    Time.parse string
  end
end
