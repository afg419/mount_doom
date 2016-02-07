class Character < ActiveRecord::Base
  belongs_to :avatar
  belongs_to :user
  belongs_to :location
  has_many :items, :as => :itemable


  def current_attributes

  end

  def bank
    avatar.skill_set.money
  end
end
