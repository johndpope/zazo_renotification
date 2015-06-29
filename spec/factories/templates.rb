FactoryGirl.define do
  factory :template do
    kind  'sms'
    name  'sms_invite_v1'
    title 'Hello!'
    body  '<%= inviter %> sent you a message.'
  end
end
