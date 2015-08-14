class User::Cell < Cell::Concept
  class MessagesTable < Cell::Concept
    property :messages

    def show
      render
    end
  end

  class ConditionsTable < Cell::Concept
    property :conditions

    def show
      render
    end
  end

  class AttributesTable < Cell::Concept
    ATTRIBUTES = [
      :id, :mkey, :status, :first_name, :last_name, :email,
      :mobile_number, :device_platform, :inviter, :invited_at
    ]

    def show
      render
    end

    private

    def id
      link_to model.id, "#{Figaro.env.statistics_api_base_url}/users/#{model.id}"
    end

    def value(attr)
      if respond_to? attr, true
        send attr
      else
        model.send attr
      end
    end
  end

  def show
    render
  end
end
