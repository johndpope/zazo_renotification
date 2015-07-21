class Query::NonMarketing < Query
  include Api

  def execute
    @data = EventsApi.new.filter :non_marketing
    set_names StatisticsApi.new(users: collect_users).fetch :names
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
        mkey:      row['invitee'],
        user:      names[row['invitee']],
        friend:    names[row['inviter']],
        time_zero: row['time_zero']
      }
    end.as_json
  end
end
