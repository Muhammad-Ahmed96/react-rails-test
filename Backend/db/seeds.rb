# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


User.create!(name: 'Admin', role: :admin, email: "admin@email.com", password: '123456')

user1 = User.create!(name: 'User 1', role: :user, email: "user1@email.com",  password: '123456')
user2 = User.create!(name: 'User 2', role: :user, email: "user2@email.com", password: 'abc123')

proj1 = Project.create(name: 'Rails Project', start_date: Date.today, duration: 3.months.to_i)
proj2 = Project.create(name: 'Python Project', start_date: Date.today, duration: 6.months.to_i)
proj3 = Project.create(name: 'AI Project', start_date: Date.today + 1.month, duration: 1.year.to_i)

t1_start_time = Time.parse("2025-07-20 08:00:00")
t1_end_time = Time.parse("2025-07-20 18:00:00")

t2_start_time = Time.parse("2025-07-20 00:00")
t2_end_time = Time.parse("2025-07-25 00:00")

t3_start_time = Time.parse("2025-07-01 09:00")
t3_end_time = Time.parse("2025-07-30 06:00")

task1 = Task.create(name: "Frontend", start_time: t1_start_time, end_time: t1_end_time, duration: t1_end_time - t1_start_time)
task2 = Task.create(name: "Backend", start_time: t2_start_time, end_time: t2_end_time, duration: t2_end_time - t2_start_time)
task3 = Task.create(name: "Devops", start_time: t3_start_time, end_time: t3_end_time, duration: t3_end_time - t3_start_time)

proj1.tasks << task1
proj3.tasks << task2
proj3.tasks << task3

user1.projects << proj1
user1.projects << proj2

user2.projects << proj2
user2.projects << proj3
