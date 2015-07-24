class Query::NonMarketing < Query
  include Api

  def execute
    @data = EventsApi.new.filter :non_marketing
    set_names StatisticsApi.new(users: collect_users).fetch :ids_and_names
  end

  private

  def collect_users
    @data.each_with_object([]) do |row, memo|
      memo << row['invitee']
      memo << row['inviter']
    end.uniq
  end

  def set_names(names)
    @data.each_with_object([]) do |row, memo|
      memo << {
        id:        names[row['invitee']] && names[row['invitee']]['id'],
        mkey:      row['invitee'],
        user:      names[row['invitee']] && names[row['invitee']]['name'],
        friend:    names[row['inviter']] && names[row['inviter']]['name'],
        time_zero: row['time_zero']
      }
    end.as_json
  end
end
