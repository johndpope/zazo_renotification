require 'rails_helper'

RSpec.describe SequencesController, type: :controller do
  let!(:sms_sequence)   { FactoryGirl.create :sms_sequence }
  let!(:email_sequence) { FactoryGirl.create :email_sequence }

  render_views

  describe 'GET #sms' do
    before { get :sms, program_id: sms_sequence.program.id }
    it_behaves_like 'response status'
  end

  describe 'GET #email' do
    before { get :email, program_id: sms_sequence.program.id }
    it_behaves_like 'response status'
  end
end
