namespace :users do
  desc 'Exports all TaskLists (with their Tasks) for the provided user to stdout (using yaml format)'

  task :export_data, [:user_email] => :environment do |task, args|
    return if args[:user_email].blank?

    user = User.find_by!(email: args[:user_email])

    task_list_attributes = user.task_lists.map do |task_list|
      attribute_hash = task_list.attributes.except('id')

      attribute_hash['users'] = [
        { email: user.email },
      ]

      task_list.tasks.each do |task|
        attribute_hash['tasks_attributes'] ||= []

        attribute_hash['tasks_attributes'] << task.attributes.except('id', 'task_list_id')
      end

      attribute_hash
    end

    puts task_list_attributes.to_yaml
  end
end
