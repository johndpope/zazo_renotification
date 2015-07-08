require 'rails_helper'

RSpec.describe ProgramsController, type: :controller do
  let!(:program) { FactoryGirl.create :program }

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
end
