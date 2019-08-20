source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.6'

# postgresql
gem 'pg', '>= 0.18', '< 2.0'

# users & auth
gem 'devise_token_auth', github: 'lynndylanhurley/devise_token_auth'

# strip input whitespaces
gem 'strip_attributes'

# the only right ruby console
gem 'pry-rails'
gem 'pry-remote'

# background job processing
gem 'sidekiq'

# proper console printing
gem 'awesome_print'

# CORS
gem 'rack-cors'

# proper json support
gem 'oj'

# image (and non-image) attachments
gem 'paperclip', github: 'thoughtbot/paperclip'

# api model serialization
# specific version because of devise_token_auth conflict
# happening otherwise
gem 'active_model_serializers', '0.10.0.rc4'

# pagination
gem 'kaminari'

# api docs
gem 'apipie-rails'

# push notifications
gem 'fcm'

# testing
gem 'rspec-rails'
gem 'factory_bot_rails'

# tests ran easily
gem 'spin'

# error reporting
gem 'rollbar'

# webserver
gem 'puma', '~> 3.7'

# reorderable/sortable lists
gem 'acts_as_list'

group :development, :test do
  # filesystem watcher (the non-polling, only-right way)
  gem 'listen', '>= 3.0.5', '< 3.2'

  # keeps the interpreter alive
  gem 'spring'

  # integrates spring with listen
  gem 'spring-watcher-listen', '~> 2.0.0'
end
