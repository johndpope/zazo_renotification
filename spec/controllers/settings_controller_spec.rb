require 'rails_helper'

RSpec.describe SettingsController, type: :controller, authenticate_with_http_basic: true do
  let(:program) { FactoryGirl.create :program }

  let(:setting_params) do
    { id: program.setting.id,
      setting: { started: true } }
  end

  let(:queries_params) do
    { program_id: program.id, query: ['NotVerified'], 'NotVerified' => '2015-05-15 00:00' }
  end

  let(:conditions_params) do
    { program_id: program.id, condition: ['NotVerified'] }
  end

  render_views

  describe 'PUT #update' do
    before { put :update, setting_params }

    it 'redirects to #options' do
      expect(subject).to redirect_to options_program_path program
    end

    it 'set started to true' do
      expect(Setting.find(setting_params[:id]).started).to eq true
    end
  end

  describe 'PATCH #queries' do
    let(:query) { Query.where(program: program).first }
    before { patch :queries, queries: queries_params }

    it 'redirects to #options' do
      expect(subject).to redirect_to options_program_path program
    end

    it 'saved into database' do
      expect(query.type.split('::').last).to eq queries_params[:query].first
      expect(query.params).to eq queries_params['NotVerified']
    end
  end

  describe 'PATCH #conditions' do
    before { patch :conditions, conditions: conditions_params }

    it 'redirects to #options' do
      expect(subject).to redirect_to options_program_path program
    end

    it 'saved into database' do
      expect(Condition.where(program: program).first.type.split('::').last).to eq conditions_params[:condition].first
    end
  end
end
