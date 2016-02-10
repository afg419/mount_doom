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

  def self.of_category(category_name)
    all.select{ |item| item.category.name == category_name if item.category}
    # joins(:category).where(category: {name: category_name})
  end

  def self.category_attributes(category_name)
    of_category(category_name).map{ |item| item.skill_set.non_zero_attributes }
    # of_category(category_name).map{ |item| item.non_zero_attributes }
  end

  def new_category
    Store.find(itemable_id).category.id
  end

  def duplication_params
    {
      name: name,
      category_id: category_id,
      label: label,
      skill_set_id: skill_set_id
    }

  end
end
