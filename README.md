# Sahha Biomarkers API Microservice

This repository is a Rails-based API microservice that utilizes the Sahha.ai API to surface biomarkers.

## Prerequisites
- Ruby version: **3.2.2** (managed by rbenv)
- Rails version: **7.1.4**
- Database: **PostgreSQL**
- Testing framework: **RSpec**
- Code linting: **RuboCop**

## Installation Guide

### 1. Install Ruby
Install Ruby using rbenv or another Ruby version manager. Ensure you are using Ruby **3.2.2**.

### 2. Install Rails
Once Ruby is installed, install Rails globally:

```bash
gem install rails -v 7.1.4
```

Verify the Rails installation:

```bash
rails -v
```
This should show `Rails 7.1.4`.

### 3. Install PostgreSQL
To install PostgreSQL on your machine:

#### Ubuntu/Debian:
```bash
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib
```

#### macOS (Homebrew):
```bash
brew install postgresql
```

Ensure PostgreSQL is running:

```bash
sudo service postgresql start   # Linux
brew services start postgresql  # macOS
```

### 4. Clone the Project
Clone the repository from GitHub to your local machine:

```bash
git clone https://github.com/your_username/sahha_biomarkers.git
cd sahha_biomarkers
```

### 5. Install Project Dependencies
Install Bundler (if not already installed):

```bash
gem install bundler
```

Install all necessary gems:

Inside the project directory, run:

```bash
bundle install
```

This will install all dependencies specified in the `Gemfile`, including `pg` (PostgreSQL), `rspec-rails`, and others.

### 6. Configure the Database
Set up environment variables:

Create a `.env` file in the project root and populate it with your database credentials.

Example `.env` file:

```
# Common database configuration
DATABASE_HOST=localhost
DATABASE_PORT=5432

# Development database settings
DEVELOPMENT_DB_NAME=sahha_biomarkers_development
DEVELOPMENT_DB_USERNAME=postgres
DEVELOPMENT_DB_PASSWORD=your_password

# Test database settings
TEST_DB_NAME=sahha_biomarkers_test
TEST_DB_USERNAME=postgres
TEST_DB_PASSWORD=your_password

# Production database settings
PRODUCTION_DB_NAME=sahha_biomarkers_production
PRODUCTION_DB_USERNAME=your_production_username
PRODUCTION_DB_PASSWORD=your_production_password
```

Create and migrate the database:

```bash
rails db:create
rails db:migrate
```

### 7. Running the Application
To run the Rails server locally:

```bash
rails s
```

The application will start, and you can access it at [http://localhost:3000](http://localhost:3000).

### 8. Running Tests
This project uses **RSpec** for testing. To run the test suite:

```bash
bundle exec rspec
```

### 9. Linting with RuboCop
To check the code for style violations using **RuboCop**:

```bash
bundle exec rubocop
```

### 10. Deployment (Optional)
If you're deploying the app to a platform like Heroku or AWS, ensure you’ve set the environment variables and the database credentials for your production environment.

## Troubleshooting

### Common Issues:
- **PostgreSQL Connection Issues**: Ensure PostgreSQL is running, and the credentials in the `.env` file match your PostgreSQL setup.
- **Bundler Not Installing Gems**: Ensure you have the correct Ruby version (**3.2.2**). If you're using rbenv, ensure it's active with the correct version by running `rbenv global 3.2.2`.