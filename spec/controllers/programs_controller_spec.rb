require 'rails_helper'

RSpec.describe ProgramsController, type: :controller, authenticate_with_http_basic: true do
  let!(:program) { FactoryGirl.create :program_with_queries }

  render_views

  describe 'GET #index' do
    before { get :index }
    it_behaves_like 'response status'
  end

  describe 'GET #new' do
    before { get :new }
    it_behaves_like 'response status'
  end

  describe 'GET #edit' do
    before { get :edit, id: program }
    it_behaves_like 'response status'
  end

  describe 'GET #options' do
    before { get :options, id: program }
    it_behaves_like 'response status'
  end

  describe 'GET #users' do
    use_vcr_cassette 'queries/not_verified', api_base_urls
    use_vcr_cassette 'queries/non_marketing', api_base_urls
    before { get :users, id: program }
    it_behaves_like 'response status'
  end
end
