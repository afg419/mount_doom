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
  end

  factory :character do
    user
    avatar
    location
  end

  factory :category do
    name "armory"
  end

  factory :store do
    name "Taylor Rules"
    location
    category
  end
end
