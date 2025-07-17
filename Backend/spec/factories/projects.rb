FactoryBot.define do
  factory :project do
    name { "Project" }
    start_date { Date.today }
    duration { 2.months.to_i }
  end
end
