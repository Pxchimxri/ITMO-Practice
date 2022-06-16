class User < ApplicationRecord
  enum :role => {client: "client", driver: "driver", admin: "admin"}
  has_many :orders

  validates :name, presence: true
  validates :active, presence: true
  validates :role, presence:true
end
