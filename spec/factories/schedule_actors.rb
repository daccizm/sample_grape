# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :actor1, class: ScheduleActor do
  	association :user, factory: :user1
  end

  factory :actor2, class: ScheduleActor do
  	association :user, factory: :user2
  end
end
