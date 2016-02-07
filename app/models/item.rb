class Item < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :category_type
  belongs_to :itemable, :polymorphic => true
  has_many :item_orders
  has_many :orders, through: :item_orders
  # has_attached_file :image
  # validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  # scope :available, -> { where(status: "Available").order(name: :asc) }
  # scope :admin_alpha, -> { order(status: :asc).order(name: :asc) }


end
