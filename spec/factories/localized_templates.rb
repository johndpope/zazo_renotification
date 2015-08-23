FactoryGirl.define do
  factory :localized_template do
    locale 'russian'
    title  'Привет!'
    body   'Вам отправили сообщение.'
  end
end
