class User < ApplicationRecord
  enum :role, { user: 0, admin: 1 }

  has_secure_password
  has_and_belongs_to_many :projects

  validates :email, presence: true, uniqueness: true
  validates :role, presence: true

  scope :search, ->(name) { where("name ilike ? AND role = ?", "%#{name.downcase()}%", User.roles[:user]).limit(5) }
end
