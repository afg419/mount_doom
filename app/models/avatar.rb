class Avatar < ActiveRecord::Base
  belongs_to :skill_set

  def skills
    skill_set.attributes.to_h.tap do |h|
      h.delete("id")
      h.delete("created_at")
      h.delete("updated_at")
    end
  end
end
