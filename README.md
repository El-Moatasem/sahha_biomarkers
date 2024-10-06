# Sahha Biomarkers API Microservice

This repository is a Rails-based API microservice that utilizes the Sahha.ai API to surface and log biomarkers.

## Prerequisites
- Ruby version: **3.2.2** (managed by rbenv)
- Rails version: **7.1.4**
- Database: **PostgreSQL**
- Testing framework: **RSpec**
- Code linting: **RuboCop**

## Installation Guide

### 1. Install Ruby
Install Ruby using rbenv or another version manager. Ensure Ruby **3.2.2** is used.

### 2. Install Rails
Install Rails globally and verify the installation:

```bash
gem install rails -v 7.1.4
rails -v  # should output Rails 7.1.4
```

### 3. Install PostgreSQL
To install PostgreSQL:

#### Ubuntu/Debian:
```bash
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib
```

#### macOS (Homebrew):
```bash
brew install postgresql
brew services start postgresql
```

### 4. Clone the Project
Clone the repository from GitHub to your local machine:

```bash
git clone https://github.com/your_username/sahha_biomarkers.git
cd sahha_biomarkers
```

### 5. Install Dependencies
Install Bundler and project gems:

```bash
gem install bundler
bundle install
```

### 6. Configure the Database
Create a `.env` file in the project root and populate it with your database credentials:

```
DATABASE_HOST=localhost
DATABASE_PORT=5432
DEVELOPMENT_DB_NAME=sahha_biomarkers_development
DEVELOPMENT_DB_USERNAME=postgres
DEVELOPMENT_DB_PASSWORD=your_password
TEST_DB_NAME=sahha_biomarkers_test
TEST_DB_USERNAME=postgres
TEST_DB_PASSWORD=your_password
```

Then create and migrate the database:

```bash
rails db:create
rails db:migrate
```

### 7. Configure Sahha API
In the `.env` file, add Sahha API credentials:

```
SAHHA_SANDBOX_CLIENT_ID=your_client_id
SAHHA_SANDBOX_CLIENT_SECRET=your_client_secret
PROFILE_TOKEN= # This will be generated after profile registration
```

### 8. API Usage

1. **Register Profile**:

   - Endpoint: `POST /biomarkers/register_profile`
   - Params: `externalId`

2. **Log Biomarker Data**:

   - Endpoint: `POST /biomarkers`
   - Body:
   
   ```json
   {
     "biomarker": {
       "biomarker_type": "heart-rate",
       "value": { "average": 72, "unit": "bpm" },
       "recorded_at": "2024-10-05T14:30:00Z",
       "externalId": "your_external_id"
     }
   }
   ```

3. **Get Profile Biomarkers**:

   - Endpoint: `GET /biomarkers/profile_biomarkers`
   - Params:
     - `categories`: ["activity"]
     - `types`: ["heart-rate"]
     - `startDateTime`, `endDateTime`: ISO format.

### 9. Running the Application
To run the Rails server locally:

```bash
rails s
```

Access it at [http://localhost:3000](http://localhost:3000).

### 10. Running Tests

```bash
bundle exec rspec
```

### 11. Linting with RuboCop

```bash
bundle exec rubocop
```

## Troubleshooting

### Common Issues:
- **401 Unauthorized Errors**: Ensure the profile token is being fetched correctly and the authorization headers are properly set.
- **PostgreSQL Connection Issues**: Ensure PostgreSQL is running, and the credentials in the `.env` file are correct.
- **Bundler Not Installing Gems**: Ensure you have the correct Ruby version (**3.2.2**). If you're using rbenv, ensure it's active with the correct version by running `rbenv global 3.2.2`.