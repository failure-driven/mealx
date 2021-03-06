source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Adding for consistent Ruby styling
gem "rubocop"
gem "rubocop-rails"
gem "rubocop-rspec"

# Feature flipping
# Flipper
gem "flipper"
# UI
gem "flipper-ui"
# Adapter
gem "flipper-active_record"

# User management
gem "devise"
gem "administrate"
gem "administrate-field-jsonb"

gem "jwt"

# email
gem "premailer-rails"

# Email sending on heroku
gem "sendgrid-ruby"

# API
gem "graphiql-rails", group: :development
gem "graphql"

# better search
gem "pg_search"

# rake tasks
gem 'colorize'

group :test do
  gem "database_cleaner"

  # Factory bot for testing
  gem "factory_bot_rails"

  gem "rspec-example_steps"
  gem "rspec-rails"
  gem "rspec-wait"

  gem "capybara", ">= 3.14"
  gem "capybara-screenshot"
  gem "selenium-webdriver"
  gem "webdrivers", "~> 3.0"

  gem "pry"
  gem "pry-rails"
  gem "pry-stack_explorer"

  gem "capybara-email"
end

group :development, :test do
  # call as my_complex_hash for awesome pretty print
  gem "awesome_print"

  # dev and test to be able to call binding.pry in specs
  gem "pry-byebug"

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # allow viewing emails in development
  gem "letter_opener"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
