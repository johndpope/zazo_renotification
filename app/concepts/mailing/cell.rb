class Mailing::Cell < Cell::Concept

  class Table < Cell::Concept
    def show
      render
    end

    private

    def entries
      model
    end
  end

  property :key, :phone, :status,
           :message, :created_at

  def show
    render
  end

  def row
    render 'row'
  end
end
