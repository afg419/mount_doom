class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_one :character

  validates :username, presence: true,
                     uniqueness: true

  enum role: %w(default admin)

  def platform_admin?
    self.role == "admin"
  end
end
