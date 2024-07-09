# frozen_string_literal: true

categories = %w[Food Accommodation Travel Entertainment Education Health Charity Miscellaneous]

categories.each do |category_name|
  Category.find_or_create_by(name: category_name)
end
