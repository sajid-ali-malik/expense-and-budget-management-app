# # This file should ensure the existence of records required to run the application in every environment (production,
# # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Example:
# #
# #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
# #     MovieGenre.find_or_create_by!(name: genre_name)
# #   end





User.delete_all
# Account.delete_all
# Category.delete_all

users = [
  {email: "sajid@gmail.com", name: 'Sajid ALi', image: 'sajid.png', dob: '1997-12-12', gender: 1},
  {email: "mudassar@gmail.com", name: 'Mudassar', image: 'Mudassar.png', dob: '1999-12-12', gender: 1},
  {email: "arfa@orayoray.com", name: 'arfa', image: 'arfa.png', dob: '2000-12-12', gender: 2}
]

# accounts = [
#   {name:"saving account", account_number:"121212", currency:"pkr", color:"green"},
#   {name:"current account", account_number:"121434312", currency:"usd", color:"yellow"}
# ]

# categories = [
#   {name:"food", icon:"star", color:"red"},
#   {name:"travel", icon:"bag", color:"green"}
# ]



users.each do |user_data|
  User.create!(user_data)
end

# accounts.each do |acccount_data|
#   Account.create!(account_data)
# end

# categories.each do |category_data|
#   Category.create!(Category_data)
# end



puts "Users seeded successfully."
