class User < ApplicationRecord
  enum :role => {client: :client, driver: :driver, admin: :admin}
  has_many :orders
end
