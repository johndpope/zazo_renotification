class Condition::NotVerified < Condition
  include Api

  def check(user)
    super do
      response = StatisticsApi.new(user: user, attrs: [:status]).fetch :attributes
      response['status'] != 'verified'
    end
  end
end
