class Query::NotVerified < Query
  include Api

  params [
    { instance: :started_at, proc: -> (value) { Time.parse value }, default: Time.now - 10.years }
  ]

  def execute
    init_params
    normalize reduce DataProviderApi.new.filter :non_verified
  end

  private

  def reduce(data)
    data.select { |row| Time.parse(row['time_zero']) >= @started_at }
  end
end
