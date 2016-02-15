class Condition::NotVerified < Condition
  include Api

  def check(user)
    super do
      # response = StatisticsApi.new(user: user, attrs: [:status]).attributes
      # todo: check specs
      response = DataProviderApi.new(user: user, attrs: :status).query :attributes
      response['status'] != 'verified'
    end
  end
end
