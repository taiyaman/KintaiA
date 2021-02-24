# coding: utf-8

User.create!(name: "Sample User",
             email: "sample@email.com",
             department: "aaa",
             password: "password",
             employees_number: 1,
             password_confirmation: "password",
             admin: true)

User.create!(name: "Sample User2",
              email: "sample2@email.com",
              department: "aaa",
              password: "password",
              password_confirmation: "password")

              User.create!(name: "Sample User3",
                email: "sample3@email.com",
                password: "password",
                department: "aaa",
                password_confirmation: "password")

                User.create!(name: "Sample Use4",
                  email: "sampl4@email.com",
                  password: "password",
                  password_confirmation: "password",
                  admin: true)


# 60.times do |n|
#                 name  = Faker::Name.name
#                 email = "sample-#{n+1}@email.com"
#                 password = "password"
#                 User.create!(name: name,
#                              email: email,
#                              password: password,
#                              password_confirmation: password)
# end
              