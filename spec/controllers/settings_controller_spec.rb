require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  let(:setting_params) do
    { id: Invite::Setting.first.id,
      invite_setting: { started: true } }
  end

  let(:queries_params) do
    { type: 'invite', query: ['NotVerified'] }
  end

  let(:conditions_params) do
    { type: 'invite', condition: ['NotVerified'] }
  end

  render_views

  describe 'GET #index' do
    before { get :index }
    it_behaves_like 'response status'
  end

  describe 'PUT #update' do
    before { put :update, setting_params }

    it 'redirects to #index' do
      expect(subject).to redirect_to action: :index
    end

    it 'set started to true' do
      expect(Invite::Setting.first.started).to eq true
    end
  end

  describe 'PATCH #queries' do
    before { patch :queries, queries: queries_params }

    it 'redirects to #index' do
      expect(subject).to redirect_to action: :index
    end

    it 'saved into database' do
      expect(Query.last.type.split('::').last).to eq queries_params[:query][0]
    end
  end

  describe 'PATCH #conditions' do
    before { patch :conditions, conditions: conditions_params }

    it 'redirects to #index' do
      expect(subject).to redirect_to action: :index
    end

    it 'saved into database' do
      expect(Condition.last.type.split('::').last).to eq conditions_params[:condition][0]
    end
  end
end
