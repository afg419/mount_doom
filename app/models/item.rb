class Item < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :category
  belongs_to :itemable, :polymorphic => true
  has_many :item_orders
  has_many :orders, through: :item_orders
  belongs_to :skill_set

  def price
    -1 * skill_set.money
  end

  def self.of_category(category_name)
    all.select{ |item| item.category.name == category_name if item.category}
    # joins(:category).where(category: {name: category_name})
  end

  def self.category_attributes(category_name)
    of_category(category_name).map{ |item| item.skill_set.non_zero_attributes }
    # of_category(category_name).map{ |item| item.non_zero_attributes }
  end

  def duplication_params
    {
      name: name,
      category_id: category_id,
      skill_set_id: skill_set_id
    }
  end
end
