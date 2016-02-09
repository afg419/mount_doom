class Character < ActiveRecord::Base
  belongs_to :avatar
  belongs_to :user
  belongs_to :location
  has_many :items, :as => :itemable
  has_many :incidents
  belongs_to :equipped_armor, :class_name => "Item"
  belongs_to :equipped_weapon, :class_name => "Item"

  def current_skills
    avatar_attributes = [avatar.attributes]

    weapon_attributes = [equipped_weapon.attributes]
    armor_attributes = [equipped_armor.attributes]

    apothecary_attributes = items.category_attributes("apothecary")
    inn_item_attributes = items.category_attributes("inn")

    character_attributes = avatar_attributes +
                           weapon_attributes +
                           armor_attributes +
                           apothecary_attributes +
                           inn_item_attributes

    sum_skills(character_attributes)
  end

  def bank
    current_skills["money"]
  end

  def hp
    current_skills["health"]
  end

  def equip_armor(item)
    equipped_armor = item
  end

  def equip_weapon(item)
    equipped_weapon = item
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
