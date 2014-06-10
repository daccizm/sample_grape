# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :iphone, class: Device do
    uuid '60A21988-BAF2-1712-0872-7ED0C7219795'
    token 'ni8yn5otzf8bhsslnj9cl9duzi2jxteeg2ejb37dd5gog7odj6ubaq1pxshf4kt7'
    os 'ios'
    initialize_with { Device.find_or_initialize_by( uuid: uuid ) }
  end

  factory :android, class: Device do
    uuid '70A21988-BAF2-1712-0872-7ED0C7219795'
    token 'ni8yn5otzf8bhsslnj9cl9duzi2jxteeg2ejb37dd5gog7odj6ubaq1pxshf4kt7'
    os 'android'
    initialize_with { Device.find_or_initialize_by( uuid: uuid ) }
  end

  factory :device1, class: Device do
    uuid '714bd0c0-f054-11e3-ac10-0800200c9a66'
    token 'ni8yn5otzf8bhsslnj9cl9duzi2jxteeg2ejb37dd5gog7odj6ubaq1pxshf4kt7'
    os 'ios'
    initialize_with { Device.find_or_initialize_by( uuid: uuid ) }
  end

  factory :device2, class: Device do
    uuid '85520170-f054-11e3-ac10-0800200c9a66'
    token 'ni8yn5otzf8bhsslnj9cl9duzi2jxteeg2ejb37dd5gog7odj6ubaq1pxshf4kt7'
    os 'ios'
    initialize_with { Device.find_or_initialize_by( uuid: uuid ) }
  end
end