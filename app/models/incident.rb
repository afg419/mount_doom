class Incident < ActiveRecord::Base
  belongs_to :skill_set
  belongs_to :character
  belongs_to :category
end
