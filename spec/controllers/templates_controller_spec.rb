require 'rails_helper'

RSpec.describe TemplatesController, type: :controller do
  let!(:template) { FactoryGirl.create :sms_template }

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
    before { get :edit, { id: template.to_param } }
    it_behaves_like 'response status'
  end
end
