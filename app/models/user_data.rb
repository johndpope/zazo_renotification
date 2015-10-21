class UserData
  APP_NAME = 'Zazo'

  attr_reader :user, :friend, :connection

  class Friend
    attr_reader :name

    def initialize(params)
      @name = params['friend']
    end
  end

  class User
    attr_reader :id, :mkey, :name

    def initialize(params)
      @id   = params['id']
      @mkey = params['mkey']
      @name = params['user']
    end
  end

  class Connection
    attr_reader :id

    def initialize(params)
      @id = params['connection_id']
    end
  end

  def initialize(params)
    params.stringify_keys!
    @user       = User.new params
    @friend     = Friend.new params
    @connection = Connection.new params
    @time_zero  = params['time_zero']
  end

  def time_zero
    @time_zero.kind_of?(Time) ? @time_zero : Time.parse(@time_zero)
  end

  def app_link
    "zazoapp.com/l/#{connection.id}"
  end

  def bind
    binding
  end
end
