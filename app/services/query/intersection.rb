class Query::Intersection
  attr_reader :queries

  def initialize(queries)
    @queries = queries
  end

  def results
    executed = queries.map(&:execute)
    return [] unless executed.size > 0
    executed[0].select do |row|
      is_present = true
      executed[0..-1].each do |query|
        is_present = false unless user_presence? row, query
      end
      is_present
    end
  end

  private

  def user_presence?(user, array)
    array.index { |x| x['mkey'] == user['mkey'] }
  end
end
