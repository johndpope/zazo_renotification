class Query::NotVerified < Query
  include Api

  def execute
    normalize StatisticsApi.new.filter :not_verified
  end

  private

  def normalize(data)
    data.each_with_object([]) do |row, memo|
      memo << {
        mkey:      row['mkey'],
        user:      row['invitee'],
        friend:    row['inviter'],
        time_zero: row['time_zero']
      }
    end.as_json
  end
end
