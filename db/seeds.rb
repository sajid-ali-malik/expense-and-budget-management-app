User.destroy_all
# Transaction.destroy_all
# Account.destroy_all
# Category.destroy_all
# Budget.destroy_all
# Label.destroy_all



# # db/seeds.rb

# # Create Users
# user1 = User.create!(email: 'user15j343e5kj434544354u8084@example.com', name: 'User One', dob: '1990-01-01', gender: 'male')
# user2 = User.create!(email: 'useouk5452322343434r43434344u8082@example.com', name: 'User Two', dob: '1985-05-15', gender: 'female')

# # Create Accounts
# account1 = Accounts::Cash.create!(user: user1, name: 'Checking Account', account_number: '123456789', currency: 'USD', color: 'blue')
# account2 = Accounts::Saving.create!(user: user2, name: 'Savings Account', account_number: '987654321', currency: 'USD', color: 'green')

# # Create Budgets
# budget1 = Budget.create!(user: user1, name: 'Monthly Groceries', amount: 500.00, start_date: '2024-01-01', end_date: '2024-01-31')
# budget2 = Budget.create!(user: user2, name: 'Vacation Fund', amount: 2000.00, start_date: '2024-06-01', end_date: '2024-06-30')

# # Create Categories
# category1 = Categories::Expense.create!(name: 'Groceries', icon: 'shopping-cart', color: 'red')
# category2 = Categories::Income.create!(name: 'Travel', icon: 'plane', color: 'blue')

# # Create Labels
# label1 = Label.create!(name: 'Urgent', color: 'red')
# label2 = Label.create!(name: 'Optional', color: 'yellow')

# # Create Transactions
# transaction1 = Transactions::Transfer.create!( category: category1, amount: 100.00, description: 'Weekly groceries', labels: 'Urgent', source_account: account1, destination_account: account2)

# transaction2 = Transactions::Transfer.create!( category: category2, amount: 1500.00, description: 'Flight tickets', labels: 'Optional',source_account: account1, destination_account: account2)

# puts "Users seeded successfully."
