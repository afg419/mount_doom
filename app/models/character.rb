class Character < ActiveRecord::Base
  has_one :avatar
  has_one :user

  def current_attributes

  end
end
