class Order < ApplicationRecord
  enum :tariff => {standard: "standard", comfort: "comfort", premium: "premium"}
  enum :status => {started: "started", on_way: "on_way", finished: "finished"}
  belongs_to :client, :class_name => "User"
  belongs_to :driver, :class_name => "User"
  has_one :message
  has_many :order_options
  has_many :options, through: :order_options
end
