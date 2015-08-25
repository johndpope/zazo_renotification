require 'rails_helper'

RSpec.describe Template::Compiler do
  let(:template) do
    title = 'Hello, <%= user.name %>!'
    body  = '<%= friend.name %> invites you to join Zazo.'
    FactoryGirl.build :template, title: title, body: body
  end
  let(:compiler) { described_class.new template }
  let(:user_data) { UserData.new FactoryGirl.build :user_data }

  describe '#preview' do
    subject { compiler.preview }
    it { is_expected.to eq 'Hello, David Gilmour! Syd Barrett invites you to join Zazo.' }
  end

  describe '#compile' do
    before { compiler.compile user_data }
    it { expect(compiler.title).to eq "Hello, #{user_data.user.name}!" }
    it { expect(compiler.body).to  eq "#{user_data.friend.name} invites you to join Zazo." }
  end
end
