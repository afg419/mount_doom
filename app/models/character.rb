class Character < ActiveRecord::Base
  belongs_to :avatar
  belongs_to :user

  def current_attributes

  end

  def bank
    avatar.skill_set.money
  end
end
