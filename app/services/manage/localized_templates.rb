class Manage::LocalizedTemplates
  attr_reader :model, :parent, :params

  def initialize(options)
    @parent = options[:parent]
    @params = options[:params]
    @model  = options[:model]
    @model  = LocalizedTemplate.new(params) unless model
  end

  def create
    model.template = parent
    model.save
  end

  def update
    model.update params
  end
end
