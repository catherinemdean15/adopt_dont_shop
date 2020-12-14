FactoryBot.define do
  factory :application do
    sequence(:name) { |n| "Name#{n}"}
    street_address { "1234 Example St." }
    city { "Denver" }
    state { "CO" }
    sequence(:zip) { |n| n + 10000}
    description { "This is the description" }
    status { ["In Progress", "Pending", "Accepted", "Rejected"].sample}
  end
end
