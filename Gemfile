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

# For API authentication (optional, if needed for user authentication with passwords)
# gem "bcrypt", "~> 3.1.7"

# For handling image processing, if you plan to work with ActiveStorage for file uploads (optional)
# gem "image_processing", "~> 1.2"

group :development, :test do
  # Debugging tool for Ruby on Rails
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]

  # RSpec for testing
  gem "rspec-rails", "~> 5.0.0"

  # Factory Bot for easily creating test data
  gem "factory_bot_rails"

  # Faker for generating fake data in tests
  gem "faker"
end

group :development do
  # Speed up commands on slow machines / big apps (optional)
  # gem "spring"
end

group :production do
  # Add Redis if you're planning to use Action Cable or caching in production
  # gem "redis", ">= 4.0.1"
end
