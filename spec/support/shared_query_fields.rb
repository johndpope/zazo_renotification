shared_context 'query fields' do
  it 'has specific fields for every row' do
    expect(subject.first.keys.sort).to eq(%w(friend mkey time_zero user))
  end
end
