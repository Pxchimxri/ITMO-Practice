class OrdersOption < ApplicationRecord
  belongs_to :order
  belongs_to :option
end
