shared_context 'response status' do
  it 'has a 200 status code' do
    expect(response.status).to eq(200)
  end
end
