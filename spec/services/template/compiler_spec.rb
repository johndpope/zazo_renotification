require 'rails_helper'

RSpec.describe Template::Compiler do
  let(:template) do
    title = 'Hello, <%= user %>!'
    body  = '<%= friend %> invites you to join Zazo.'
    FactoryGirl.build :template, title: title, body: body
  end
  let(:compiler) { described_class.new template }
  let(:user) { FactoryGirl.build :user_data}

  describe 'preview' do
    subject { compiler.preview }
    it { is_expected.to eq 'Hello, David Gilmour! Syd Barrett invites you to join Zazo.' }
  end

  describe 'compile' do
    before { compiler.compile user }
    it { expect(compiler.title).to eq "Hello, #{user['user']}!" }
    it { expect(compiler.body).to  eq "#{user['friend']} invites you to join Zazo." }
  end
end
