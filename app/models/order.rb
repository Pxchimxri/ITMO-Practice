class Order < ApplicationRecord
  enum :tariff => {standard: :standard, comfort: :comfort, premium: :premium}
  enum :status => {finished: :finished, not_finished: :not_finished}
  belongs_to :client, :class_name => "User"
  belongs_to :driver, :class_name => "User"
  belongs_to :message
  has_many :order_options
  has_many :options, through: :order_options
end
