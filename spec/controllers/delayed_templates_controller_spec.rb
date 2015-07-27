require 'rails_helper'

RSpec.describe DelayedTemplatesController, type: :controller, authenticate_with_http_basic: true do
  let!(:sms_delayed_template)   { FactoryGirl.create :sms_delayed_template }
  let!(:email_delayed_template) { FactoryGirl.create :email_delayed_template }

  render_views

  describe 'GET #sms' do
    before { get :sms, program_id: sms_delayed_template.program.id }
    it_behaves_like 'response status'
  end

  describe 'GET #email' do
    before { get :email, program_id: sms_delayed_template.program.id }
    it_behaves_like 'response status'
  end
end
