class Avatar < ActiveRecord::Base
  belongs_to :skill_set

  scope :admin_alpha, -> { order(name: :asc) }
end
