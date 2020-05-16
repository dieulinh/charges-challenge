# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[Payment, Customer].each do |table|
  ActiveRecord::Base.connection.execute("TRUNCATE #{table.table_name}")
end

# Customer 1:
#   First Name: Johny
#   Last Name: Flow

# Customer 2:
#   First Name: Raj
#   Last Name: Jamnis

# Customer 3:
#   First Name: Andrew
#   Last Name: Chung

# Customer 4:
#   First Name: Mike
#   Last Name: Smith
# Seed 20 transactions (charges) into the system:

# 10 Should be successful transactions:
#   - 5 Should be linked to Customer 1
#   - 3 Should be linked to Customer 2
#   - 1 Should be linked to Customer 3
#   - 1 Should be linked to Customer 4

# 5 Should be transactions that failed:
#   - 3 Should be linked to Customer 3
#   - 2 Should be linked to Customer 4

# 5 should be disputed:
#   - 3 should be linked to Customer 1
#   - 2 should be linked to customer 2

customer1 = Customer.create!(first_name: 'Johny', last_name: 'Flow')
customer2 = Customer.create!(first_name: 'Raj', last_name: 'Jamnis')
customer3 = Customer.create!(first_name: 'Andrew', last_name: 'Chung')
customer4 = Customer.create!(first_name: 'Mike', last_name: 'Smith')

5.times { Payment.create(created: Time.zone.now.to_i, paid: true, amount: rand(1000), customer: customer1, currency: 'usd', refunded: false)}
3.times { Payment.create(created: Time.zone.now.to_i, paid: true, amount: rand(1000), customer: customer2, currency: 'usd', refunded: false)}
Payment.create(created: Time.zone.now.to_i, paid: true,amount: rand(1000), customer: customer3, currency: 'usd', refunded: false)
Payment.create(created: Time.zone.now.to_i, paid: true, amount: rand(1000), customer: customer4, currency: 'usd', refunded: false)

3.times { Payment.create(created: Time.zone.now.to_i, paid: false, amount: rand(1000), customer: customer3, currency: 'usd', refunded: false)}
2.times { Payment.create(created: Time.zone.now.to_i, paid: false, amount: rand(1000), customer: customer4, currency: 'usd', refunded: false)}

3.times { Payment.create(created: Time.zone.now.to_i, paid: true, amount: rand(1000), customer: customer1, currency: 'usd', refunded: true)}
2.times { Payment.create(created: Time.zone.now.to_i, paid: true, amount: rand(1000), customer: customer2, currency: 'usd', refunded: true)}
