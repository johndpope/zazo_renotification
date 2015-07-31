class Query::NotVerified < Query
  include Api

  params [
    { instance: :started_at, proc: -> (value) { Time.parse value }, default: Time.now - 10.years }
  ]

  def execute
    init_params
    normalize_and_reduce StatisticsApi.new.filter :not_verified
  end

  private

  def normalize_and_reduce(data)
    data.each_with_object([]) do |row, memo|
      memo << {
        id:        row['id'],
        mkey:      row['mkey'],
        user:      row['invitee'],
        friend:    row['inviter'],
        time_zero: row['time_zero']
      } if Time.parse(row['time_zero']) >= @started_at
    end.as_json
  end
end
