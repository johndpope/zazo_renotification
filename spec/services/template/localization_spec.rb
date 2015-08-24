require 'rails_helper'

RSpec.describe Template::Localization do
  let(:template) { FactoryGirl.create :template_localized, body: 'You received a message.' }
  let(:instance) { described_class.new mkey, template }

  describe '#select' do
    subject { instance.select }

    context 'when user from russia' do
      use_vcr_cassette 'services/template/user_from_russia', api_base_urls
      let(:mkey) { 'GBAHb0482YxlJ0kYwbIS' }

      it { expect(subject.title).to eq 'Привет!' }
      it { expect(subject.body).to eq  'Вам отправили сообщение.' }
      it { expect(instance.send :user_locale).to eq :russian }
    end

    context 'when user from ukraine' do
      use_vcr_cassette 'services/template/user_from_ukraine', api_base_urls
      let(:mkey) { 'dz4X0EvprPJO6fGysT8X' }

      it { expect(subject.title).to eq 'Привет!' }
      it { expect(subject.body).to eq  'Вам отправили сообщение.' }
      it { expect(instance.send :user_locale).to eq :russian }
    end

    context 'when user from usa' do
      use_vcr_cassette 'services/template/user_from_usa', api_base_urls
      let(:mkey) { '7qdanSEmctZ2jPnYA0a1' }

      it { expect(subject.title).to eq 'Hello!' }
      it { expect(subject.body).to eq  'You received a message.' }
      it { expect(instance.send :user_locale).to eq :default }
    end

    context 'when mkey is incorrect' do
      use_vcr_cassette 'services/template/incorrect_user', api_base_urls
      let(:mkey) { 'xxxxxxxxxxxxxxxxxxxx' }

      it { expect(subject.title).to eq 'Hello!' }
      it { expect(subject.body).to eq  'You received a message.' }
      it { expect(instance.send :user_locale).to eq :default }
    end
  end
end
