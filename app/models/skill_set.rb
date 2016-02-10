class SkillSet < ActiveRecord::Base
  def attributes(display_price = 1)
    {
     "strength" => strength.to_i,
    "dexterity" => dexterity.to_i,
    "defence"   => defence.to_i,
 "intelligence" => intelligence.to_i,
        "speed" => speed.to_i,
        "money" => display_price * money.to_i,
       "health" => health.to_i
     }
  end

  def non_zero_attributes
    attributes.select do |k,v|
      v != 0 && k != "money"
    end
  end
end
