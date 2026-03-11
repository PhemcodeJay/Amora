source "https://rubygems.org"

gem "public_suffix", "~> 5.1.0"
gem "addressable", "~> 2.8.0"
# gem "capybara"
# gem "selenium-webdriver"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1.2"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use sqlite3 as the database for Active Record (temporary until PostgreSQL works)
gem "sqlite3", ">= 2.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

# Authentication
gem "devise"

# File Upload - Using ActiveStorage instead of CarrierWave (to avoid mimemagic issues)
# gem 'carrierwave', '~> 2.0'  # Temporarily disabled due to mimemagic dependency
# gem 'mimemagic', '~> 0.3.10' # Temporarily disabled

# Image processing
gem 'mini_magick' # rubocop:disable Style/StringLiterals

# For production storage (AWS S3)
gem "fog-aws"

# Real-time features
gem 'redis', "~> 4.0" # rubocop:disable Style/StringLiterals

# Background jobs
gem 'sidekiq' # rubocop:disable Style/StringLiterals

# Authorization
gem 'pundit'  # rubocop:disable Style/StringLiterals

# Location-based features
gem 'geocoder' # rubocop:disable Style/StringLiterals

# Advanced searching/filtering
gem 'ransack' # rubocop:disable Style/StringLiterals

# Fake data generation
gem 'faker' # rubocop:disable Style/StringLiterals

# Frontend styling and JavaScript
gem 'bootstrap', '~> 5.0' # rubocop:disable Style/StringLiterals
gem 'jquery-rails' # rubocop:disable Style/StringLiterals
gem 'font-awesome-sass', '~> 6.7' # rubocop:disable Style/StringLiterals

# API CORS handling
gem 'rack-cors' # rubocop:disable Style/StringLiterals

# Third-party authentication
gem 'omniauth' # rubocop:disable Style/StringLiterals
gem 'omniauth-facebook' # rubocop:disable Style/StringLiterals
gem 'omniauth-google-oauth2' # rubocop:disable Style/StringLiterals
gem 'omniauth-twitter' # rubocop:disable Style/StringLiterals

# Force older psych version for compatibility
gem 'psych', '< 5.0.0' # rubocop:disable Style/StringLiterals

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Audits gems for known security defects (use config/bundler-audit.yml to ignore issues)
  gem "bundler-audit", require: false

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end


# PostgreSQL (commented out - uncomment when ready to switch from SQLite3)
# gem "pg", "~> 1.1"

gem "dartsass-rails", "~> 0.5.1"
