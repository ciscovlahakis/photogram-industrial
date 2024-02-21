desc "Fill the database tables with some sample data"
task sample_data: :environment do
  puts "Creating sample data"

  if Rails.env.development?
    FollowRequest.destroy_all
    Comment.destroy_all
    Like.destroy_all
    Photo.destroy_all
    User.destroy_all
  end

  12.times do
    name = Faker::Name.first_name
    u = User.create(
      email: "#{name.downcase}@example.com",
      password: "password",
      username: name,
      private: [true, false].sample,
    )

    puts u.errors.full_messages unless u.persisted?
  end

  puts "There are now #{User.count} users."

  User.all.each do |first_user|
    User.where.not(id: first_user.id).each do |second_user|
      if rand < 0.75
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.keys.sample
        )
      end
    end
  end

  User.all.each do |user|
    rand(1..15).times do
      photo = user.own_photos.create(
        caption: Faker::Quote.jack_handey,
        image: "https://robohash.org/#{rand(9999)}"
      )

      user.followers.each do |follower|
        if rand < 0.5
          photo.likes.create(fan: follower)
        end

        if rand < 0.25
          photo.comments.create(
            body: Faker::Quote.jack_handey,
            author: follower
          )
        end
      end
    end
  end

  puts "Sample data creation complete."
  puts "There are now #{User.count} users."
  puts "There are now #{FollowRequest.count} follow requests."
  puts "There are now #{Photo.count} photos."
  puts "There are now #{Like.count} likes."
  puts "There are now #{Comment.count} comments."
end
