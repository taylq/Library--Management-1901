puts "1. Seeding Admin"
  User.create!(name: "admin", email: "admin@gmail.com", password: "123456", role: 1)

puts "2. Seeding User"
20.times do
  User.create!(name: FFaker::Name.name, email: FFaker::Internet.email, password: FFaker::Internet.password, role: 0)
end

puts "3. Seeding Author"
10.times do
  Author.create!(name: FFaker::Name.name, note: FFaker::Job.title)
end

puts "4. Seeding Category"
5.times do
  Category.create!(name: FFaker::Animal.common_name)
end

puts "5. Seeding Publisher"
10.times do
  Publisher.create!(name: FFaker::Name.name, phone: FFaker::PhoneNumber.phone_number, address: FFaker::Address.city)
end

puts "6. Seeding Book"
Publisher.all.each do |publisher|
  Category.all.each do |category|
    Book.create!(category_id: category.id, publisher_id: publisher.id,
      name: FFaker::Name.name, content: FFaker::Lorem.paragraphs,
      number_of_page: 20, status: 0, image: FFaker::Image.url)
  end
end

puts "7. Seeding Book_Author"
3.times do
  Book.all.each do |book|
    AuthorsBook.create!(book_id: book.id, author_id: rand(1..10))
  end
end

puts "8. Seeding Follower"
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
