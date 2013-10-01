# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

user_names = ["Axel Rose", "Liza Cornwell", "Angelica Cucumber", "Douglas MacDonald", "John Kerth", "Andy Lowercase", "Michael Pain", "Piter Voight", "Teresa Cardionale", "Paul Lazy", "Kamil Stoch", "Lars Whynot"]

user_ids = []
user_names.each do |u|
	email = u.split(' ').join('.').downcase + "@example.com"
	user = User.create(email: email, username: u, password: "test123", password_confirmation: "test123")
	user_ids << user.id
	p "User: #{u} created"
end

tags = Faker::Lorem.words(40)

200.times do |i|
	random_title = Faker::Lorem.sentence
	random_text = "<p>" + Faker::Lorem.paragraphs(2+Random.rand(21)).join('</p><p>') + "</p>"
	random_user = user_ids[rand(user_ids.size)]
	random_tags = []
	(1+rand(6)).times do
		random_tags << tags[rand(tags.size)]
	end
	post = Post.create(title: random_title, content: random_text, user_id: random_user, tag_list: random_tags.join(', '))
	comments_count = rand(15)
	comments_count.times do |j|
		random_user = user_ids[rand(user_ids.size)]
		random_text = Faker::Lorem.paragraph(rand(15))
		post.comments.create(user_id: random_user, content: random_text)
	end
	p "Post '#{random_title}' with #{comments_count} comments created"
end

