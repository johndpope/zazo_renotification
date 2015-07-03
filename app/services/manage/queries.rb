class Manage::Queries
  attr_accessor :program, :queries

  def initialize(params)
    @queries = params[:queries]
    @program = params[:program]
  end

  def update
    remove_existing
    queries.each do |query|
      program.queries << Classifier.new([:query, query]).klass.new
    end
    program.save!
  end

  private

  def remove_existing
    program.queries.each(&:destroy)
  end
end
