# require 'faker'

# @test_teacher = Teacher.create(user_name: 'Juan', email: 'sjdonado@uninorte.edu.co', phone: '1234567890', password: 12345, country: 'Colombia', city: 'Barranquilla', address: 'testtesttest', profile_picture: 'https://app-javeriana.s3.amazonaws.com/e4051da3-0f0e-46ef-afb3-6b800e1248881522190811.png', deanery: 'Math')
# @test_teacher_2 = Teacher.create(user_name: 'Brian', email: 'brianramirez482@gmail.com', phone: '1234567890', password: 12345, country: 'Colombia', city: 'Barranquilla', address: 'testtesttest', profile_picture: 'https://app-javeriana.s3.amazonaws.com/e4051da3-0f0e-46ef-afb3-6b800e1248881522190811.png', deanery: 'Math')
# @test_teacher_3 = Teacher.create(user_name: 'Roberto De La Vega Vallejo', email: 'rdelavega@javeriana.edu.co', phone: '1234567890', password: 12345, country: 'Colombia', city: 'Barranquilla', address: 'testtesttest', profile_picture: 'https://app-javeriana.s3.amazonaws.com/e4051da3-0f0e-46ef-afb3-6b800e1248881522190811.png', deanery: 'Math')
# # @class_one = JavClass.create(code: '123456789', name: 'Test class teacher_one', deanery: 'tetstesttest', teacher: @test_teacher)
# # @class_two = JavClass.create(code: '987654321', name: 'Test class teacher_two', deanery: 'tetstesttest', teacher: @test_teacher_2)

# 20.times do | n |
#   if n % 2 == 0
#     JavClass.create(code: Faker::Number.number(10), name: "Test class #{n}", deanery: 'tetstesttest', teacher: @test_teacher)
#   else
#     JavClass.create(code: Faker::Number.number(10), name: "Test class #{n}", deanery: 'tetstesttest', teacher: @test_teacher_2)
#   end
# end

# 40.times do | n |
#   student = Student.create(identity_number: Faker::Number.number(10), name: Faker::Name.name, age: "19", nick_name: Faker::Internet.user_name, profile_picture: 'https://app-javeriana.s3.amazonaws.com/e4051da3-0f0e-46ef-afb3-6b800e1248881522190811.png')
#   JavClass.find(Faker::Number.between(1, 18)).student << student
#   JavClass.find(2).student << student
# end

# :first_name, :last_name, :cc, :email, :phone, :password, :location, :profile_picture