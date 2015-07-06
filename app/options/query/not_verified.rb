class Query::NotVerified < Query
  include Api

  def execute
    events_api.filter_data :not_verified
  end
end
