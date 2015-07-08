shared_context 'query fields' do
  it 'has specific fields for every row' do
    expect(subject.first.keys).to eq(%w(mkey time_zero invitee inviter))
  end
end
