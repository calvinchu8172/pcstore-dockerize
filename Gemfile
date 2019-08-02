source 'https://rubygems.org'

gem 'rails', '4.2.6'
# Use sqlite3 as the database for Active Record
gem 'mysql2', '0.4.5'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
gem 'unicorn'

gem 'strip_attributes'
gem 'mini_magick'
gem 'aasm'
gem "rails-i18n"
gem 'rails_config', '~> 0.4.2'

# ---------- #
# - for UI - #
# ---------- #
gem 'country_select' #country_selector
gem 'simple_form'
gem 'kaminari'
gem 'bootstrap-kaminari-views'
gem 'bootstrap-sass'
gem "font-awesome-rails"
gem 'carrierwave'
gem 'fog'
gem 'hamlit'
gem 'ransack', '1.8.10'
gem 'jquery-ui-rails'
gem 'cocoon'
gem 'rails-jquery-autocomplete'

# --------------------- #
# - for Log In system - #
# --------------------- #
gem 'devise'
gem 'omniauth'
gem 'omniauth-oauth2', '1.3.1'
gem 'omniauth-facebook' #oauth for facebook

# --------------- #
# - for Payment - #
# ----------------#
gem 'braintree' #for paypal

group :development, :test do
  gem 'better_errors' #better error message
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'pry'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.0.2'
  # gem 'sqlite3' #change to mysql
  gem 'pry-rails' #irb replacement
  gem 'hirb-unicode' #better console looking

end

group :test do
  gem 'minitest-reporters'
end

group :production do
  # gem 'pg' #for heroku database but not for Linode deploy
end


