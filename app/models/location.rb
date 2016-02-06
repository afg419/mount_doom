class Location < ActiveRecord::Base
  has_many :characters

  def to_param
    slug
  end
end
