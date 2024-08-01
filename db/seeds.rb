require "faker"

case Rails.env
when "development"

    User.create(
        email: "admin@gmail.com",
        password: ENV['SEEDS_PASS'],
        password_confirmation: ENV['SEEDS_PASS'],
        role: "admin"
    )

    User.create(
        email: "fanat@gmail.com",
        password: ENV['SEEDS_PASS'],
        password_confirmation: ENV['SEEDS_PASS'],
        role: "fan"
    )

    User.create(
        email: "user@gmail.com",
        password: ENV['SEEDS_PASS'],
        password_confirmation: ENV['SEEDS_PASS']
    )

    30.times do
        password = Faker::Internet.password(min_length: 6)
        User.create(
            email: Faker::Internet.unique.email(domain: 'gmail.com'),
            password: password,
            password_confirmation: password
        )
    end

    ActiveStorage::Blob.create!(
        key: 'w7zijcg8xc4kit0d0y051nxdygen',
        filename: 'fish_for_seeds.jpg',
        content_type: 'image/jpeg',
        metadata: '{"identified":true,"width":540,"height":360,"analyzed":true}',
        service_name: 'cloudinary',
        byte_size: 27909,
        checksum: '/1UkXdyBz4cr1bGPz36aLQ=='
    )

    15.times do
        NewsStory.create(
            title: Faker::Movie.title.capitalize,
            published_at: Faker::Time.between(from: DateTime.now - 1.year, to: DateTime.now + 1.month)
        )
    end
    (1..15).each do |news_story_id|
        ActiveStorage::Attachment.create!(
            record_type: 'NewsStory',
            record_id: news_story_id,
            name: 'cover',
            blob_id: 1
        )
        ActionText::RichText.create!(
            record_type: 'NewsStory',
            record_id: news_story_id,
            name: 'content',
            body: Faker::Lorem.paragraph_by_chars
        )
    end

    20.times do
        Atribute.create(
            name: Faker::Commerce.product_name,
            price: Faker::Number.number(digits: 3),
            avaliable: Atribute.avaliables.keys.sample
        )
    end
    (1..20).each do |atribute_id|
        ActiveStorage::Attachment.create!(
            record_type: 'Atribute',
            record_id: atribute_id,
            name: 'atribute_photos',
            blob_id: 1
        )
    end

    30.times do
        Video.create(
            name: Faker::Book.title,
            youtube_id: ["4xUEkxgnGqs", "SfsY2DJlIdE", "rCYCM8HYE1s", "0PY9176gEi8", "cax1HcvsOOY"].sample,
            video_type: Video.video_types.keys.sample
        )
    end

when "production"

    user = User.where(email: "ternofieldarmy@gmail.com").first_or_initialize
    user.update!(
        password: ENV['SEEDS_PASS'],
        password_confirmation: ENV['SEEDS_PASS'],
        role: "admin"
    )

end