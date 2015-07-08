require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  let(:program) { FactoryGirl.create :program }

  let(:setting_params) do
    { id: program.setting.id,
      setting: { started: true } }
  end

  let(:queries_params) do
    { program_id: program.id, query: ['NotVerified'] }
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
    before { patch :queries, queries: queries_params }

    it 'redirects to #options' do
      expect(subject).to redirect_to options_program_path program
    end

    it 'saved into database' do
      expect(Query.where(program: program).first.type.split('::').last).to eq queries_params[:query].first
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
