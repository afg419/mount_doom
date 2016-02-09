class Incident < ActiveRecord::Base
  belongs_to :skill_set
  belongs_to :character
end
