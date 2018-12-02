class User < ActiveRecord::Base
  has_many :foods

  has_secure_password
  validates :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
