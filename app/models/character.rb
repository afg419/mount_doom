class Character < ActiveRecord::Base
  belongs_to :avatar
  belongs_to :user
  belongs_to :location
  has_many :items, :as => :itemable
  has_many :incidents

  def current_skills
    avatar_attributes = avatar.skill_set.attributes
    item_attributes = items.map{ |item| item.skill_set.attributes }
    character_attribute_array = item_attributes << avatar_attributes
    sum_skills(character_attribute_array)
  end

  def bank
    current_skills["money"]
  end

  def hp
    current_skills["health"]
  end

private

  def sum_skills(attribute_array)
    total_skills = {
      "strength" => 0,
      "dexterity" => 0,
      "intelligence" => 0,
      "speed" => 0,
      "health" => 0,
      "money" => 0
    }

    attribute_array.reduce(total_skills) do |acc, skill_set|
      total_skills.keys.each do |attribute|
        acc[attribute] += skill_set[attribute]
      end
      acc
    end
  end
end
