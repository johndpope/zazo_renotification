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

  def connection_link(connection_id)
    return '' unless connection_id
    link_to connection_id, "#{Figaro.env.statistics_api_base_url}/connections/#{connection_id}"
  end
end
