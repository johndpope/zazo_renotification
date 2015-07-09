class Query::NonMarketing < Query
  include Api

  def execute
    @data  = EventsApiFilter.new.data :non_marketing
    set_names StatisticsApiFetch.new.data :mkey, users: collect_mkeys
  end

  private

  def collect_mkeys
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
