# coding: utf-8

User.create!(name: "Admin",
              email: "admin@email.com",
              department: "管理",
              employees_number: 1001,
              uid: 2,
              password: "password",
              superior: false,
              admin: true)

User.create!(name: "上長A",
              email: "test1@email.com",
              department: "開発",
              employees_number: 1002,
              uid: 3,
              password: "password",
              superior: true,
              admin: false)

User.create!(name: "上長B",
                email: "test2@email.com",
                department: "営業",
                employees_number: 1003,
                uid: 4,
                password: "password",
                superior: true,
                admin: false)

User.create!(name: "テスト1",
                  email: "test3@email.com",
                  department: "総務",
                  employees_number: 1004,
                  uid: 5,
                  password: "password",
                  superior: false,
                  admin: false)

User.create!(name: "テスト2",
                    email: "test4@email.com",
                    department: "人事",
                    employees_number: 1005,
                    uid: 6,
                    password: "password",
                    superior: false,
                    admin: false)

# 60.times do |n|
#                 name  = Faker::Name.name
#                 email = "sample-#{n+1}@email.com"
#                 password = "password"
#                 User.create!(name: name,
#                              email: email,
#                              password: password,
#                              password_confirmation: password)
# end
              