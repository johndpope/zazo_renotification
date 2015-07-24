class UserData
  attr_reader :id, :mkey, :user, :friend

  def initialize(params)
    params.stringify_keys!
    @id        = params['id']
    @mkey      = params['mkey']
    @user      = params['user']
    @friend    = params['friend']
    @time_zero = params['time_zero']
  end

  def time_zero
    @time_zero.kind_of?(Time) ? @time_zero : Time.parse(@time_zero)
  end

  def bind
    binding
  end
end
