# Sahha Biomarkers API Microservice

This is a Ruby on Rails-based microservice that interacts with the Sahha.ai API for logging and retrieving biomarkers. It uses PostgreSQL for the database and includes endpoints for creating and retrieving biomarker data.

## Prerequisites
- Ruby version: **3.2.2**
- Rails version: **7.1.4**
- Database: **PostgreSQL**
- Authentication: Sahha API Client ID and Secret

## Installation

### 1. Clone the Repository
Clone the repository from GitHub:

```bash
git clone https://github.com/your-username/sahha-biomarkers-api.git
cd sahha-biomarkers-api
```

### 2. Install Dependencies
Ensure you have Bundler installed:

```bash
gem install bundler
```

Then, install project dependencies:

```bash
bundle install
```

### 3. Set Up Environment Variables
Create a `.env` file in the root of your project and populate it with your credentials:

```bash
SAHHA_SANDBOX_CLIENT_ID=your-client-id
SAHHA_SANDBOX_CLIENT_SECRET=your-client-secret
DATABASE_HOST=localhost
DATABASE_PORT=5432
DEVELOPMENT_DB_NAME=sahha_biomarkers_development
DEVELOPMENT_DB_USERNAME=your_db_user
DEVELOPMENT_DB_PASSWORD=your_db_password
```

### 4. Create and Migrate the Database

```bash
rails db:create
rails db:migrate
```

### 5. Run the Server
To run the Rails server locally:

```bash
rails s
```

Your application will be accessible at [http://localhost:3000](http://localhost:3000).

## Deployment to Heroku

### 1. Login to Heroku

```bash
heroku login
```

### 2. Create a New Heroku App

```bash
heroku create sahha-apis-app
```

### 3. Add PostgreSQL

```bash
heroku addons:create heroku-postgresql:hobby-dev --app sahha-apis-app
```

### 4. Deploy to Heroku

```bash
git push heroku main
```

### 5. Migrate the Database on Heroku

```bash
heroku run rails db:migrate --app sahha-apis-app
```

### 6. Set Up Environment Variables on Heroku

```bash
heroku config:set SAHHA_SANDBOX_CLIENT_ID=your-client-id --app sahha-apis-app
heroku config:set SAHHA_SANDBOX_CLIENT_SECRET=your-client-secret --app sahha-apis-app
```

## API Endpoints

### 1. Create a Biomarker
- **URL**: `POST /biomarkers`
- **Description**: This endpoint creates a new biomarker record.
- **Headers**: `Content-Type: application/json`
- **Sample Request**:

  ```json
  {
    "biomarker": {
      "biomarker_type": "sleep_debt",
      "value": {
        "average": 5,
        "unit": "hrs"
      },
      "recorded_at": "2024-10-05T14:30:00Z",
      "category": "sleep"
    },
    "externalId": "C85330AD-C691-453C-8CB6-353AB75FD611"
  }
  ```
- **Sample Response**:

  ```json
  {
    "status": "Biomarker created successfully",
    "data": {
      "id": 7,
      "biomarker_type": "sleep_debt",
      "value": {
        "average": 5,
        "unit": "hrs"
      },
      "recorded_at": "2024-10-05T14:30:00.000Z",
      "created_at": "2024-10-07T18:39:46.975Z",
      "updated_at": "2024-10-07T18:39:46.975Z",
      "category": "sleep",
      "client_id": "E9lj0r9SV7sn5NnhE2m82UjdaoonfsDj",
      "external_id": "C85330AD-C691-453C-8CB6-353AB75FD611"
    }
  }
  ```

### 2. Retrieve Biomarkers
- **URL**: `GET /biomarkers/retrieve`
- **Description**: Retrieve biomarkers based on `client_id`, `external_id`, `categories`, and `biomarker_types`.
- **Query Parameters**:
  - `categories[]`: Array of categories (e.g., vitals, activity)
  - `biomarker_types[]`: Array of biomarker types (e.g., step_count, heart-rate)
  - `externalId`: External ID of the profile
  - `startDateTime`: Start of the date range (ISO 8601 format)
  - `endDateTime`: End of the date range (ISO 8601 format)
- **Sample Request**:

  ```bash
  GET https://sahha-apis-app-5b239a710b76.herokuapp.com/biomarkers/retrieve?categories[]=vitals&categories[]=activity&biomarker_types[]=step_count&biomarker_types[]=heart-rate&externalId=C85330AD-C691-453C-8CB6-353AB75FD611&startDateTime=2024-10-05T00:00:00Z&endDateTime=2024-10-06T00:00:00Z
  ```
- **Sample Response**:

  ```json
  [
    {
      "id": 4,
      "biomarker_type": "heart-rate",
      "value": {
        "unit": "bmp",
        "average": 90
      },
      "recorded_at": "2024-10-05T14:30:00.000Z",
      "created_at": "2024-10-07T18:35:23.780Z",
      "updated_at": "2024-10-07T18:35:23.780Z",
      "category": "vitals",
      "client_id": "E9lj0r9SV7sn5NnhE2m82UjdaoonfsDj",
      "external_id": "C85330AD-C691-453C-8CB6-353AB75FD611"
    },
    {
      "id": 5,
      "biomarker_type": "heart-rate",
      "value": {
        "unit": "bmp",
        "average": 90
      },
      "recorded_at": "2024-10-05T14:30:00.000Z",
      "created_at": "2024-10-07T18:35:33.287Z",
      "updated_at": "2024-10-07T18:35:33.287Z",
      "category": "vitals",
      "client_id": "E9lj0r9SV7sn5NnhE2m82UjdaoonfsDj",
      "external_id": "C85330AD-C691-453C-8CB6-353AB75FD611"
    }
  ]
  ```

## Updating the Client ID and Secret
If you want to change the logging Sahha dashboard, simply update the `SAHHA_SANDBOX_CLIENT_ID` and `SAHHA_SANDBOX_CLIENT_SECRET` environment variables either in your `.env` file (for local development) or in your Heroku configuration:

```bash
heroku config:set SAHHA_SANDBOX_CLIENT_ID=new-client-id --app sahha-apis-app
heroku config:set SAHHA_SANDBOX_CLIENT_SECRET=new-client-secret --app sahha-apis-app
```

## Conclusion
This API microservice allows you to log and retrieve biomarker data using the Sahha.ai API. It is deployed on Heroku and can be easily managed through the environment variables. For any changes, simply update the configurations and redeploy to Heroku.