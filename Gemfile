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

# Use tzinfo-data for timezone information on Windows
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]

# For secure password hashing in authentication systems
gem "bcrypt", "~> 3.1.7"

# Use Sidekiq for background jobs
gem "sidekiq"

# Handling image processing (optional for file uploads via Active Storage)
gem "image_processing", "~> 1.2"

# Use Active Model serializers for rendering JSON (optional)
gem "active_model_serializers", "~> 0.10.0"

group :development, :test do
  # Debugging tool for Ruby on Rails
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]

  # RSpec for testing
  gem "rspec-rails", "~> 5.0.0"

  # Factory Bot for creating test data
  gem "factory_bot_rails"

  # Faker for generating fake data in tests
  gem "faker"

  # Guard for running RSpec tests automatically when files change
  gem "guard", require: false
  gem "guard-rspec", require: false

  # SimpleCov for test coverage
  gem "simplecov", require: false

  # Database cleaner for cleaning up test databases between test runs
  gem "database_cleaner-active_record"

  # RuboCop for code linting and style checking
  gem "rubocop", require: false

  # Bullet gem to help kill N+1 queries and unused eager loading in development
  gem "bullet"
end

group :development do
  # Speed up commands on slow machines / big apps (optional)
  gem "spring"

  # Annotate gem to automatically add comments summarizing table schema to your models
  gem "annotate"
end

group :production do
  # Add Redis for Action Cable, caching, and Sidekiq background jobs
  gem "redis", ">= 4.0.1"
end
