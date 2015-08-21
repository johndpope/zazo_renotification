class Template::SyntaxValidator < ActiveModel::Validator
  def validate(record)
    [:title, :body].each do |key|
      status, error = Template::Compiler.new(model(record)).validate key
      record.errors.add(key, error) unless status
    end
  end

  private

  def model(record)
    Template.new({
      title: record.title,
      body:  record.body,
    })
  end
end
