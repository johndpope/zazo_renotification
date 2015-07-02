class Manage::Queries
  attr_accessor :type, :queries

  def initialize(params)
    @queries = params[:queries]
    @type    = params[:type].classify
  end

  def update
    remove_existing
    queries.each do |query|
      Classifier.new([type, :query, query]).klass.new.save
    end
  end

  private

  def remove_existing
    Query.by_type(type).each(&:destroy)
  end
end
