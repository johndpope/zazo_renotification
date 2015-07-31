class Manage::Queries
  attr_accessor :program, :queries, :params

  def initialize(params)
    @queries = params[:queries]
    @program = params[:program]
    @params  = prepare_params params[:params]
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

  def prepare_params(params)
    params.keys.each_with_object({}) do |query, memo|
      memo[query] = params[query].remove(' ').split(',')
    end
  end
end
