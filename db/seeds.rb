# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(name: "Admin", role: "admin", email: "admin@admin.com", password: "123456", active: true)

clients = User.create!(
  [
    {name: "Client1", role: "client", email: "client1@client.com", password: "123456", active: true},
    {name: "Client2", role: "client", email: "client2@client.com", password: "123456", active: true}
  ]
)

drivers = User.create!(
  [
    {name: "Driver1", role: "driver", email: "driver1@driver.com", password: "123456", active: true},
    {name: "Driver2", role: "driver", email: "driver2@driver.com", password: "123456", active: true}
  ]
)

Order.create!(price: 10.1, interest_rate: 0.1, tariff: "standard", status: "finished", from: "Pushkina", to: "Kolotushkina", client: clients.first, driver: drivers.first)
Order.create!(price: 12345.54321, interest_rate: 0.15, tariff: "standard", status: "looking_for_car", from: "Sablina", to: "Grablina", client: clients.last)
Order.create!(price: 65.6, interest_rate: 0.5, tariff: "premium", status: "canceled", from: "Safina", to: "Grafina", client: clients.first, driver: drivers.last)
Order.create!(price: 15689.67, interest_rate: 0.1, tariff: "comfort", status: "finished", from: "Nikonorova", to: "Egorova", client: clients.first, driver: drivers.first)