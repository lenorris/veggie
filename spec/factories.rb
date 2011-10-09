# encoding: utf-8

FactoryGirl.define do
  
  factory :restaurant do
    name "Tony's deli"
    info "Excellent italian restaurant."
  end
  
  factory :branch do
    restaurant
    street_address "Hämeentie 15"
    city "Helsinki"
  end

  factory :user do
    username "user"
    email "user@user.org"
    password "userpass12321321£@$£@532"
  end

  factory :comment do
    user
    restaurant
    body "Fine italian dining. I highly recommend this place."
  end
  
end
