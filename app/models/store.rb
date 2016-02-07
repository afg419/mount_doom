class Store < ActiveRecord::Base
  belongs_to :location
  belongs_to :category
  has_many :items, :as => :itemable

  def self.type(category_name)
    Store.joins(:categories).where(category: {name: category_name})
  end
end
