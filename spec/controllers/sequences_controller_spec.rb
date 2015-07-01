require 'rails_helper'

RSpec.describe SequencesController, type: :controller do
  let!(:sms_sequence)   { FactoryGirl.create :sms_sequence }
  let!(:email_sequence) { FactoryGirl.create :email_sequence }

  render_views

  describe 'GET #index' do
    before { get :index }
    it_behaves_like 'response status'
  end

  describe 'GET #sms' do
    before { get 'sms' }
    it_behaves_like 'response status'
  end

  describe 'GET #email' do
    before { get 'email' }
    it_behaves_like 'response status'
  end
end
