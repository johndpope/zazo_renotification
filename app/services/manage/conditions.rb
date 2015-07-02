class Manage::Conditions
  attr_accessor :type, :conditions

  def initialize(params)
    @conditions = params[:conditions]
    @type       = params[:type].classify
  end

  def update
    remove_existing
    conditions.each do |condition|
      Classifier.new([type, :condition, condition]).klass.new.save
    end
  end

  private

  def remove_existing
    Condition.by_type(type).each(&:destroy)
  end
end
