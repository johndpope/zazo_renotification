class User::Cell < Cell::Concept
  property :id, :mkey, :status, :first_name, :last_name,
           :email, :mobile_number, :device_platform,
           :inviter, :invited_at, :messages, :conditions

  def show
    render
  end

  private

  def user_id
    link_to id, "#{Figaro.env.statistics_api_base_url}/users/#{id}"
  end

  def attributes
    %i(user_id mkey status first_name last_name email mobile_number device_platform inviter invited_at)
  end
end
