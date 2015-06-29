require 'rails_helper'

RSpec.describe TemplatesController, type: :controller do
  let(:template) { FactoryGirl.create :template }

  describe 'GET #index' do
    before { get :index }

    it_behaves_like 'response status'
    it 'assigns all templates as @templates' do
      expect(assigns(:templates)).to eq([template])
    end
  end

  describe 'GET #new' do
    before { get :new }

    it_behaves_like 'response status'
    it 'assigns a new template as @template' do
      expect(assigns(:template)).to be_a_new(Template)
    end
  end

  describe 'GET #edit' do
    before { get :edit, {:id => template.to_param} }

    it_behaves_like 'response status'
    it 'assigns the requested template as @template' do
      expect(assigns(:template)).to eq(template)
    end
  end
end
