namespace :users do
  desc 'Imports TaskLists (with their Tasks and TaskListUsers) from the provided yaml file'

  task :import_data, [:filename] => :environment do |task, args|
    return if args[:filename].blank?

    YAML.load_file(args[:filename]).each do |attribute_hash|
      task_list = TaskList.new(attribute_hash.except('users'))

      attribute_hash['users'].each do |user_data_hash|
        task_list.users << User.find_by!(email: user_data_hash[:email])
      end

      task_list.save!
    end
  end
end
