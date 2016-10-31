class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates_confirmation_of :password

  has_secure_password
end
