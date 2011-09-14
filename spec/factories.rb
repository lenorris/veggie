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
    password "userpass"
  end

  
end
