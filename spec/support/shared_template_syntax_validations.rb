shared_context 'template syntax validations' do
  it 'fails with invalid title' do
    template = template_incorrect_title
    template.valid?
    expect(template.errors[:title].size).to eq(1)
    expect(template.errors[:title][0]).to eq('String can\'t be coerced into Fixnum')
  end

  it 'fails with invalid body' do
    template = template_incorrect_body
    template.valid?
    expect(template.errors[:body].size).to eq(1)
    expect(template.errors[:body][0]).to include('undefined local variable or method')
  end
end
