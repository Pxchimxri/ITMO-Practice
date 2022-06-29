class Order < ApplicationRecord
  enum :tariff => {standard: "standard", comfort: "comfort", premium: "premium"}
  enum :status => {finished: "finished", looking_for_driver: "looking_for_driver", canceled: "canceled", in_process: "in_process", on_way: "on_way"}
  belongs_to :client, :class_name => "User"
  belongs_to :driver, :class_name => "User", optional: true
  has_one :message
  has_many :order_options
  has_many :options, through: :order_options

  RATES = [1,2,3,4,5]

  validates :from, presence: true
  validates :to, presence: true
  validates :interest_rate, presence: true
  validates :price, presence: true
  validates :client_id, presence: true
  validates :tariff, presence: true
  validates :status, presence: true
end
