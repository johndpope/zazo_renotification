class Query::NotVerified < Query
  include Api

  params [
    { instance: :started_at, proc: -> (value) { Time.parse value }, default: Time.now - 10.years }
  ]

  def execute
    normalize StatisticsApi.new.filter :not_verified
  end

  private

  def normalize(data)
    data.each_with_object([]) do |row, memo|
      memo << {
        id:        row['id'],
        mkey:      row['mkey'],
        user:      row['invitee'],
        friend:    row['inviter'],
        time_zero: row['time_zero']
      }
    end.as_json
  end
end
