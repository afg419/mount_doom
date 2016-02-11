class Store < ActiveRecord::Base
  belongs_to :location
  belongs_to :category
  has_many :items, :as => :itemable

  scope :admin_alpha, -> { order(name: :asc) }

  def to_param
    category.name
  end

  def self.type(category_name)
    Store.joins(:categories).where(category: {name: category_name})
  end

  def apothecary_or_inn?
    category.name == "inn" || category.name == "apothecary"
  end
end
