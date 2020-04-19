FactoryBot.define do
  factory :task_note do
    task
    content { '<!doctype html><html><body><p>Some text</p></body></html>' }
  end
end
