# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user1, class: User do
    nickname '品川　太郎'
    initialize_with { User.find_or_initialize_by( nickname: nickname ) }

    trait :with_iphone do
      devices { [create(:iphone)] }
    end
  end

  factory :user2, class: User do
    nickname '大崎　太郎'
    initialize_with { User.find_or_initialize_by( nickname: nickname ) }

    trait :with_android do
      devices { [create(:android)] }
    end
  end

  factory :actor_user1, class: User do
    nickname '五反田　太郎'
    initialize_with { User.find_or_initialize_by( nickname: nickname ) }
  end

  factory :actor_user2, class: User do
    nickname 'Gotanda　Jiro'
    initialize_with { User.find_or_initialize_by( nickname: nickname ) }
  end

end