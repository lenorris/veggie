source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'haml-rails'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'therubyracer'

# Heroku for deployment

gem 'heroku'
group :production do
  gem 'pg' # Heroku requires this
end

# Use unicorn as the web server
# gem 'unicorn'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test, :development do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'rspec-rails', "~> 2.6"
  gem 'factory_girl_rails'
  gem 'capybara'

end
