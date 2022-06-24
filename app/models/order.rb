class Order < ApplicationRecord
  enum :tariff => {standard: "standard", comfort: "comfort", premium: "premium"}
  enum :status => {looking_for_car: "looking_for_car", accepted: "accepted", on_way: "on_way", finished: "finished", canceled: "canceled"}
  belongs_to :client, :class_name => "User"
  belongs_to :driver, :class_name => "User", optional: true
  has_one :message
  has_many :order_options
  has_many :options, through: :order_options

  attr_accessor :service_income
  attr_accessor :driver_income
end
