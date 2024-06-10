User.destroy_all
Account.destroy_all
Category.destroy_all
Budget.destroy_all
Label.destroy_all
Transaction.destroy_all

# users = [
#   {email: "sajid@gmail.com", name: 'Sajid ALi', image: 'sajid.png', dob: '1997-12-12', gender: 1},
#   {email: "mudassar@gmail.com", name: 'Mudassar', image: 'Mudassar.png', dob: '1999-12-12', gender: 1},
#   {email: "arfa@orayoray.com", name: 'arfa', image: 'arfa.png', dob: '2000-12-12', gender: 2}
# ]

# accounts = [
#   {name:"saving account", account_number:"121212", currency:"pkr", color:"green"},
#   {name:"current account", account_number:"121434312", currency:"usd", color:"yellow"}
# ]

# categories = [
#   {name:"food", icon:"star", color:"red"},
#   {name:"travel", icon:"bag", color:"green"}
# ]



# users.each do |user_data|
#   User.create!(user_data)
# end

# accounts.each do |acccount_data|
#   Account.create!(account_data)
# end

# categories.each do |category_data|
#   Category.create!(Category_data)
# end
#
#


# db/seeds.rb

# Create Users
user1 = User.create!(email: 'user1@example.com', name: 'User One', dob: '1990-01-01', gender: 2)
user2 = User.create!(email: 'user2@example.com', name: 'User Two', dob: '1985-05-15', gender: 1)

# Create Accounts
account1 = Account.create!(user: user1, name: 'Checking Account', account_number: '123456789', nature_of_account: 0, currency: 'USD', color: 'blue')
account2 = Account.create!(user: user2, name: 'Savings Account', account_number: '987654321', nature_of_account: 1, currency: 'USD', color: 'green')

# Create Budgets
budget1 = Budget.create!(user: user1, name: 'Monthly Groceries', amount: 500.00, start_date: '2024-01-01', end_date: '2024-01-31')
budget2 = Budget.create!(user: user2, name: 'Vacation Fund', amount: 2000.00, start_date: '2024-06-01', end_date: '2024-06-30')

# Create Categories
category1 = Category.create!(name: 'Groceries', icon: 'shopping-cart', color: 'red', kind: 0)
category2 = Category.create!(name: 'Travel', icon: 'plane', color: 'blue', kind: 1)

# # Create Budget Categories
# budget_category.create!(budget: budget1, category: category1)
# budget_category.create!(budget: budget2, category: category2)

# Create Labels
label1 = Label.create!(name: 'Urgent', color: 'red')
label2 = Label.create!(name: 'Optional', color: 'yellow')

# Create Transactions
transaction1 = Transaction.create!(account: account1, category: category1, amount: 100.00, type: TransferTransaction, description: 'Weekly groceries', labels: 'Urgent', created_at: Time.now, updated_at: Time.now)
transaction2 = Transaction.create!(account: account2, category: category2, amount: 1500.00, type: TransferTransaction, description: 'Flight tickets', labels: 'Optional', created_at: Time.now, updated_at: Time.now)







puts "Users seeded successfully."
