require 'faker'

def add_journey(journey, student)
	journey["journey_stop"] += ";#{student.location}"
	journey["capacity"] -= 1
	journey.users << student
end

@test_student = User.create(first_name: 'Robert', last_name: 'Test', cc: '1234567899', email: 'robert@test.com', coins: 500, phone: '310675432', password: '12345', role: 'student', location: 'test', profile_picture: 'https://mvp-resources.s3.amazonaws.com/faeba478-9837-4c6f-a9f4-717f0ef85ebd1523736119.png')
# @test_teacher_2 = Teacher.create(user_name: 'Brian', email: 'brianramirez482@gmail.com', phone: '1234567890', password: 12345, country: 'Colombia', city: 'Barranquilla', address: 'testtesttest', profile_picture: 'https://app-javeriana.s3.amazonaws.com/e4051da3-0f0e-46ef-afb3-6b800e1248881522190811.png', deanery: 'Math')
# @test_teacher_3 = Teacher.create(user_name: 'Roberto De La Vega Vallejo', email: 'rdelavega@javeriana.edu.co', phone: '1234567890', password: 12345, country: 'Colombia', city: 'Barranquilla', address: 'testtesttest', profile_picture: 'https://app-javeriana.s3.amazonaws.com/e4051da3-0f0e-46ef-afb3-6b800e1248881522190811.png', deanery: 'Math')
# # @class_one = JavClass.create(code: '123456789', name: 'Test class teacher_one', deanery: 'tetstesttest', teacher: @test_teacher)
# # @class_two = JavClass.create(code: '987654321', name: 'Test class teacher_two', deanery: 'tetstesttest', teacher: @test_teacher_2)

20.times do | n |
  journey = Journey.create(code: Faker::Number.number(10), start: "Start #{n}", end: "End #{n}", capacity: 10, price: 5, journey_stop: 'test;test;test', duration: 30, tags: 'test;test;test')
  driver = User.create(first_name: Faker::Name.name, last_name: Faker::Name.last_name, cc: Faker::Number.number(10), email: Faker::Internet.email, phone: Faker::Number.number(10), password: '12345', role: 'driver', location: "#{11.020743 + (Faker::Number.number(2).to_f / 100)}, #{74.850721 + (Faker::Number.number(2).to_f / 100)}", profile_picture: 'https://mvp-resources.s3.amazonaws.com/faeba478-9837-4c6f-a9f4-717f0ef85ebd1523736119.png')
  add_journey(journey, driver)
end

40.times do | n |
  student = User.create(first_name: Faker::Name.name, last_name: Faker::Name.last_name, cc: Faker::Number.number(10), email: Faker::Internet.email, phone: Faker::Number.number(10), password: '12345', role: 'student', location: "#{11.020743 + (Faker::Number.number(2).to_f / 100)}, #{74.850721 + (Faker::Number.number(2).to_f / 100)}", profile_picture: 'https://mvp-resources.s3.amazonaws.com/faeba478-9837-4c6f-a9f4-717f0ef85ebd1523736119.png')
  add_journey(Journey.find(Faker::Number.between(1, 18)), student)
  # Journey.find(2).student << test_student
end

add_journey(Journey.find(1), @test_student)
add_journey(Journey.find(9), @test_student)
add_journey(Journey.find(7), @test_student)
add_journey(Journey.find(4), @test_student)