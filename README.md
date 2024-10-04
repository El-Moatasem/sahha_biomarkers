# Sahha Biomarkers API Microservice

This project is a Rails API microservice that surfaces at least 3 biomarkers (e.g., heart rate, calories burnt, sleep data) using the Sahha.ai API. It is built using Ruby on Rails, PostgreSQL as the database, and various development and testing tools.

## Prerequisites

Before you begin, ensure you have the following installed:

- **rbenv** for Ruby version management
- **Ruby 3.2.2**
- **Rails 7.1.4**
- **PostgreSQL**
- **Bundler**
- **Git**

### 1. Install rbenv and Ruby

1. **Install rbenv** (for managing Ruby versions):

   - **macOS (Homebrew)**:
     ```bash
     brew install rbenv
     rbenv init
     ```

   - **Ubuntu/Debian**:
     ```bash
     sudo apt update
     sudo apt install -y rbenv
     ```

   Add rbenv to your shell:
   ```bash
   echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
   echo 'eval "$(rbenv init -)"' >> ~/.bashrc
   exec $SHELL
   ```

### 2. Install Rails

Once Ruby is installed, install Rails globally:

```bash
gem install rails -v 7.1.4
   ```

   