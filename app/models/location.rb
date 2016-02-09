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
    @inn ||= "#"
  end

  def blacksmith
    @blacksmith ||= stores.find{|store| store.category.name == "blacksmith"}
    @blacksmith ||= "#"
  end

  def apothecary
    @apothecary ||= stores.find{|store| store.category.name == "apothecary"}
    @apothecary ||= "#"
  end
end
