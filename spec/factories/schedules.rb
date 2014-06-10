# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :new_schedule, class: Schedule do
    title '京都旅行'
    image 'image010'
    description '毎年恒例の京都旅行に行きましょう！'
    start_datetime '201406061200'
    end_datetime '201406092000'
    all_day true
    place '京都駅'
    latitude '32.00000009'
    longitude '132.00000009'
    lock_version 0
  end

  factory :schedule1, class: Schedule do
    guid 'd8ff3060-eb84-11e3-ac10-0800200c9a66'
    title '大阪旅行'
    image 'image001'
    description '毎年恒例の大阪旅行に行きましょう！'
    start_datetime '201406021200'
    end_datetime '201406032000'
    all_day false
    place '大阪城'
    latitude '32.00000001'
    longitude '132.00000001'
    lock_version 0

    initialize_with { Schedule.find_or_initialize_by( guid: guid ) }

    trait :owner_user1 do
      user { create(:user1, :with_iphone) }
      actors { [create(:actor1), create(:actor2)] }
    end
  end

  factory :schedule2, class: Schedule do
    guid '2e2f5b00-eb85-11e3-ac10-0800200c9a66'
    title '東京マラソン'
    image 'image002'
    description '一緒に走りましょう！'
    start_datetime '201406200930'
    end_datetime '201406201800'
    all_day true
    place '東京駅'
    latitude '32.50000001'
    longitude '132.50000001'
    lock_version 3

    initialize_with { Schedule.find_or_initialize_by( guid: guid ) }

    trait :owner_user2 do
      user { create(:user2, :with_android) }
      actors { [create(:actor2)] }
    end
  end
end
