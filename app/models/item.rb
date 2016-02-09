class Item < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :category
  belongs_to :itemable, :polymorphic => true
  has_many :item_orders
  has_many :orders, through: :item_orders
  belongs_to :skill_set

  scope :admin_alpha, -> { order(name: :asc) }

  def price
    -1 * skill_set.money if skill_set
  end

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
