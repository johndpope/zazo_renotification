class Query::NonMarketing < Query
  include Api

  def execute
    init_params
    # @data = EventsApi.new.filter :non_marketing
    # todo: check specs
    @data = DataProviderApi.new.filter :non_marketing
    set_results ids_and_names, connection_ids
  end

  private

  def ids_and_names
    users = @data.each_with_object([]) do |row, memo|
      memo << row['invitee']
      memo << row['inviter']
    end.uniq
    # StatisticsApi.new(users: users).fetch :ids_and_names
    # todo: check specs
    DataProviderApi.new(users: users).query_post :ids_and_names
  end

  def connection_ids
    users_friends = @data.each_with_object({ users: [], friends: [] }) do |row, memo|
      memo[:users]   << row['invitee']
      memo[:friends] << row['inviter']
    end
    users_friends[:users].uniq!
    users_friends[:friends].uniq!
    # StatisticsApi.new(users_friends).fetch :connection_ids
    # todo: check specs
    DataProviderApi.new(users_friends).query_post(:connection_ids).each_with_object({}) do |row, memo|
      memo[row['relation']] = row['connection_id']
    end
  end

  def set_results(names, connections)
    @data.each_with_object([]) do |row, memo|
      memo << {
        id:        names[row['invitee']] && names[row['invitee']]['id'],
        mkey:      row['invitee'],
        user:      names[row['invitee']] && names[row['invitee']]['name'],
        friend:    names[row['inviter']] && names[row['inviter']]['name'],
        time_zero: row['time_zero'],
        connection_id: connections["#{row['invitee']}-#{row['inviter']}"]
      }
    end.as_json
  end
end
