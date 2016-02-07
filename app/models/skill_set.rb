class SkillSet < ActiveRecord::Base
  def attributes(display_price = 1)
    {
     "strength" => strength,
    "dexterity" => dexterity,
 "intelligence" => intelligence,
        "speed" => speed,
        "money" => display_price * money,
       "health" => health
     }
  end
end
