class Condition::NotVerified < Condition
  include Api

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def check
    response = StatisticsApi.new(user: user, attrs: [:status]).fetch :attributes
    response['status'] != 'verified'
  rescue Faraday::ClientError
    return false
  end
end
