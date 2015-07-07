class Query::NotVerified < Query
  include Api

  def execute
    StatisticsApi.new.data :not_verified
  end
end
