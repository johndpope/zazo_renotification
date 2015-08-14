class User
  attr_reader :id, :mkey, :status, :first_name, :last_name,
              :email, :mobile_number, :device_platform,
              :inviter, :invited_at, :messages, :conditions

  def initialize(mkey)
    @mkey = mkey
    set_attrs
    set_inviter
    set_messages
    set_conditions
  end

  private

  def set_attrs
    attrs  = %i{id status first_name last_name email mobile_number device_platform}
    values = StatisticsApi.new(user: mkey, attrs: attrs).attributes
    attrs.each do |attr|
      instance_variable_set "@#{attr}".to_sym, values[attr.to_s]
    end
  end

  def set_inviter
    data = StatisticsApi.new(users: [mkey]).filter(:specific_users)[0]
    @inviter    = data['inviter']
    @invited_at = data['time_zero']
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
