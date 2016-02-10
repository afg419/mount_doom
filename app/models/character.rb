class Character < ActiveRecord::Base
  belongs_to :avatar
  belongs_to :user
  belongs_to :location
  has_many :items, :as => :itemable
  has_many :incidents
  belongs_to :equipped_armor, :class_name => "Item"
  belongs_to :equipped_weapon, :class_name => "Item"

  def bank
    items.reduce(avatar.skill_set.money.to_i) do |acc, item|
      acc + item.skill_set.money.to_i
    end
  end

  def hp
    items.reduce(avatar.skill_set.health.to_i) do |acc, item|
      acc + item.skill_set.health.to_i
    end
  end

  

  def current_skills
    avatar_attributes = [avatar.skill_set.attributes]
    apothecary_attributes = items.category_attributes("apothecary")
    inn_item_attributes = items.category_attributes("inn")
    character_attributes = avatar_attributes +
                           equipped_weapon_attributes +
                           equipped_armor_attributes +
                           apothecary_attributes +
                           inn_item_attributes

    sum_skills(character_attributes)
  end


  def equip_armor(item)
    self.equipped_armor = item
    self.save
  end

  def equip_weapon(item)
    self.equipped_weapon = item
    self.save
  end

private

  def equipped_weapon_attributes
    if equipped_weapon
      weapon_attributes = [equipped_weapon.skill_set.attributes]
    else
      [empty_skills]
    end
  end

  def equipped_armor_attributes
    if equipped_armor
      armor_attributes = [equipped_armor.skill_set.attributes]
    else
      [empty_skills]
    end
  end

  def empty_skills
    {
      "strength" => 0,
      "defence" => 0,
      "dexterity" => 0,
      "intelligence" => 0,
      "speed" => 0,
      "health" => 0,
      "money" => 0
    }
  end

  def sum_skills(attribute_array)
    total_skills = empty_skills

    attribute_array.reduce(total_skills) do |acc, skill_set|
      acc.merge(skill_set){|k, v1, v2| v1 + v2}
    end
  end
end
