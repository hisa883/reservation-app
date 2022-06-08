# coding: utf-8

User.create!(name: "店長",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
            admin: true)

60.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

Store.create!(name: "1号店",
              tel: "111-1111-1111",
              number_of_rooms: 20,
              image: "1.jpg",
              detail: "1号店では〇〇が特徴です.")

Store.create!(name: "2号店",
              tel: "222-2222-2222",
              number_of_rooms: 20,
              image: "2.jpg",
              detail: "2号店では〇〇が特徴です.")

Store.create!(name: "3号店",
              tel: "333-3333-3333",
              number_of_rooms: 20,
              image: "3.jpg",
              detail: "3号店では〇〇が特徴です.")