source 'https://rubygems.org'

ruby '2.6.5'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails'

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
gem 'panko_serializer'

# pagination
gem 'kaminari'

# api docs
gem 'apipie-rails'

# push notifications
gem 'apnotic'

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

# geolocation for activerecord
gem 'geocoder'

# deployments
gem 'capistrano'
gem 'capistrano-rails'
gem 'capistrano-passenger'
gem 'capistrano-rbenv'
gem 'capistrano-sidekiq'
## required for capistrano with ssh_agent disabled
gem 'bcrypt_pbkdf'
gem 'ed25519'

group :development, :test do
  # filesystem watcher (the non-polling, only-right way)
  gem 'listen', '>= 3.0.5', '< 3.2'

  # keeps the interpreter alive
  gem 'spring'

  # integrates spring with listen
  gem 'spring-watcher-listen', '~> 2.0.0'
end
