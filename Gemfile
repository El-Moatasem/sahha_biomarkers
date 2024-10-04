source "https://rubygems.org"

# Specify Ruby version
ruby "3.2.2"

# Rails version
gem "rails", "~> 7.1.4"

# Use PostgreSQL as the database for Active Record
gem "pg", ">= 1.1"

# Use Puma as the app server
gem "puma", ">= 5.0"

# For CORS handling (useful if your API will be accessed from a browser or other domains)
gem "rack-cors"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  # Debugging tool for Ruby on Rails
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]

  # RSpec for testing
  gem "rspec-rails", "~> 5.0.0"

  # Factory Bot for creating test data
  gem "factory_bot_rails"

  # Faker for generating fake data in tests
  gem "faker"

  # RuboCop for code linting and style checking
  gem "rubocop", require: false
end

group :production do
  # Add Redis for Sidekiq or caching if needed (optional)
  # gem "redis", ">= 4.0.1"
end


