class Query::Cell < Cell::Concept
  def show
    render
  end

  private

  def parse_time(string)
    Time.parse string
  end

  def user_link(user_id)
    return '' unless user_id
    link_to user_id, "#{Figaro.env.statistics_api_base_url}/users/#{user_id}"
  end
end
