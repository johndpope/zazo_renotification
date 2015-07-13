class Condition::NotVerified < Condition
  include Api

  def check(user)
    response = StatisticsApi.new(user: user, attrs: [:status]).fetch :attributes
    response['status'] != 'verified'
  rescue Faraday::ClientError
    return false
  end
end
