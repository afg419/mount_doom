class Incident < ActiveRecord::Base
  belongs_to :skill_set
  belongs_to :character
  belongs_to :category

  def self.total_injury_attributes
    all.map{|incident| incident.skill_set.attributes}
  end

  def price
    -1 * skill_set.money if skill_set
  end

end
