class Order < ApplicationRecord
  enum :tariff => {standard: "standard", comfort: "comfort", premium: "premium"}
  enum :status => {finished: "finished", not_finished: "not_finished"}
  belongs_to :client, :class_name => "User"
  belongs_to :driver, :class_name => "User"
  has_one :message
  has_many :order_options
  has_many :options, through: :order_options


  validates :from, presence: true
  validates :to, presence: true
  validates :interest_rate, presence: true
  validates :price, presence: true
  validates :client_id, presence: true
  validates :driver_id, presence: true
  validates :tariff, presence: true
  validates :status, presence: true
end