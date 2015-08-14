class User::Cell < Cell::Concept
  property :mkey, :status, :first_name, :last_name,
           :email, :mobile_number, :device_platform,
           :inviter, :invited_at, :messages, :conditions

  def show
    render
  end

  private

  def id
    link_to model.id, "#{Figaro.env.statistics_api_base_url}/users/#{model.id}"
  end

  def attributes
    %i(id mkey status first_name last_name email mobile_number device_platform inviter invited_at)
  end
end
