class User
  class NotFound < StandardError; end

  attr_reader :id, :mkey, :status, :first_name, :last_name,
              :mobile_number, :country, :device_platform,
              :inviter, :invited_at, :messages, :conditions,
              :connection_id

  def self.find(mkey)
    self.new mkey
  rescue Faraday::ClientError => e
    WriteLog.faraday_error self, e
    raise NotFound, "User with mkey '#{mkey}' not found"
  end

  def initialize(mkey)
    @mkey = mkey
    set_attrs
    set_messages
    set_conditions
    set_inviter_and_connection
  end

  private

  def set_attrs
    attrs  = %i{id status first_name last_name mobile_number device_platform country}
    values = DataProviderApi.new(user: mkey, attrs: attrs).query :attributes
    attrs.each do |attr|
      instance_variable_set "@#{attr}".to_sym, values[attr.to_s]
    end
  end

  def set_inviter_and_connection
    data = DataProviderApi.new(users: [mkey]).filter(:specific_users)[0]
    @inviter       = data['inviter']
    @invited_at    = data['time_zero']
    @connection_id = data['connection_id']
  end

  def set_messages
    @messages = Message.where(target: mkey).order(:id)
  end

  def set_conditions
    @conditions = Condition.nested.map do |cond|
      { name:   cond.name,
        result: cond.new.check(mkey) }
    end
  end
end
