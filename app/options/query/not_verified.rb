class Query::NotVerified < Query
  include Api

  def execute
    StatisticsApiFilter.new.data :not_verified
  end
end
