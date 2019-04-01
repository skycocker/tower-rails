FactoryBot.define do
  factory :task do
    task_list
    sequence(:content) { |n| "Task-#{n}" }
    sequence(:list_position)
  end
end
