class Avatar < ActiveRecord::Base
  belongs_to :skill_set

  scope :admin_alpha, -> { order(name: :asc) }
  scope :active, -> { where(status: "active") }

  def money
    skill_set.money if skill_set
  end

  def strength
    skill_set.strength if skill_set
  end

  def intelligence
    skill_set.intelligence if skill_set
  end

  def dexterity
    skill_set.dexterity if skill_set
  end

  def health
    skill_set.health if skill_set
  end

  def speed
    skill_set.speed if skill_set
  end
end
