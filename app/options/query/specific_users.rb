class Query::SpecificUsers < Query
  include Api

  params [
    { instance: :users, proc: -> (value) { value.split(' ').map(&:strip) }, default: [] }
  ]

  def execute
    init_params
    normalize @users.empty? ? [] : DataProviderApi.new(users: @users).filter(:specific_users)
  end
end
