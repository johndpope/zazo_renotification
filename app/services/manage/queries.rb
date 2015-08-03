class Manage::Queries
  attr_reader :program, :queries, :params, :error

  def initialize(params)
    @queries = params[:queries]
    @program = params[:program]
    @params  = params[:params]
  end

  def update
    return false unless valid?
    remove_existing
    queries.each do |query|
      program.queries << Classifier.new([:query, query]).klass.new(params: params[query])
    end
    program.save!
    true
  end

  def valid?
    queries.each do |query|
      Classifier.new([:query, query]).klass.new(params: params[query]).init_params
    end
    return true
  rescue Query::ArgumentError => e
    @error = e.message
    return false
  end

  private

  def remove_existing
    program.queries.each(&:destroy)
  end
end
