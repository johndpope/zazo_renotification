class Manage::Conditions
  attr_accessor :program, :conditions

  def initialize(params)
    @conditions = params[:conditions]
    @program    = params[:program]
  end

  def update
    remove_existing
    conditions.each do |condition|
      program.conditions << Classifier.new([:condition, condition]).klass.new
    end
    program.save!
  end

  private

  def remove_existing
    program.conditions.each(&:destroy)
  end
end
