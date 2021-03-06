 FactoryGirl.define do
  factory :user do
    username "Taylor"
    password "password"
    role 0
  end

  factory :avatar do
    name "Legolas"
    image_url "blahblah"
    skill_set
  end

  factory :skill_set do
    strength 10
    dexterity 10
    intelligence 10
    speed 10
    money 10
    health 10
  end

  factory :location do
    name "Bree"
    slug "bree"
    next_location_id 134
  end

  factory :character do
    user
    avatar
    location
    money 10
  end

  factory :category do
    name "armory"
  end

  factory :item do
    name
    skill_set
    category
    label "poison"
  end

  factory :store do
    name "Taylor Rules"
    location
    category
  end

  sequence :name do |n|
    "Item #{n}"
  end
end
