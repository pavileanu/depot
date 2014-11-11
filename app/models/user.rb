class User < ActiveRecord::Base
  has_one :image
  validates :name, presence: true, uniqueness: true
  has_secure_password

end
