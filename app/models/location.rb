class Location < ActiveRecord::Base
  has_many :characters
  has_many :stores

  def to_param
    slug
  end

  def armory
    @armory ||= stores.find{|store| store.category.name == "armory"}
  end

  def inn
    @inn ||= stores.find{|store| store.category.name == "inn"}
  end

  def blacksmith
    @blacksmith ||= stores.stores.find{|store| store.category.name == "blacksmith"}
  end

  def apothecary
    @apothecary ||= stores.stores.find{|store| store.category.name == "apothecary"}
  end
end
