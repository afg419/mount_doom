class Category < ActiveRecord::Base
  has_many :chips
  validates :name, presence: true, uniqueness: true

  def gimee_your_chips
    chips.available
  end

  def category_index_image
    if name == "Avocado Category"
      "http://i.imgur.com/StaBSGO.jpg"
    elsif name == "Coconut Category"
      "http://i.imgur.com/gn4vqHt.jpg"
    else
      "http://i.imgur.com/tvZ8urm.jpg"
    end
  end

  def category_image
    if name == "Avocado Category"
      img = "http://i.imgur.com/mKdOCAX.jpg"
    elsif name == "Coconut Category"
      img = "http://i.imgur.com/GbRqTze.jpg"
    else
      img = "http://i.imgur.com/aeO1MYa.jpg"
    end
  end
end
