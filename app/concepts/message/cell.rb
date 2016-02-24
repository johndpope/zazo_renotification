class Message::Cell < Cell::Concept
  class Table < Cell::Concept
    def show
      render
    end

    private

    def messages
      model
    end
  end

  property :id, :order, :target,
           :title, :body, :send_at

  def show
    render
  end
end
