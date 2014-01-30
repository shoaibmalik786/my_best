source 'https://rubygems.org'

gem 'rails', '4.0.0'
gem 'pg'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'sass-rails', '~> 4.0.0'
gem 'haml-rails'
gem 'turbolinks'
gem 'therubyracer'
gem 'paperclip'

# bootstrap
gem 'bootstrap-sass-rails'
gem 'font-awesome-rails'

# devise
gem 'devise', "3.0.0"
gem 'omniauth-twitter'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'
gem 'koala', "~> 1.8.0rc1"

# form processing
gem 'virtus'
gem 'reform', github: 'apotonick/reform' # until 0.2.2 is released
gem 'twitter-typeahead-rails'#, github: 'yourabi/twitter-typeahead-rails'
gem 'phony_rails'

# other
gem 'inherited_resources'
gem 'naught'
gem 'wisper'
gem 'holder_rails'
gem 'enumerize'
gem 'dotenv-rails'

# geocoding
gem 'factual-api'
gem 'geocoder'

group :doc do
  gem 'sdoc', require: false
end

group :test do
  gem 'shoulda-matchers'
  gem 'json_spec'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'guard'
  gem 'guard-rspec'
  gem 'factory_girl_rails'
end

group :development do
  gem 'web-console', '~> 1.0.2'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry'
  gem 'pry-debugger'
end

# Use unicorn as the app server
gem 'unicorn'
gem 'capistrano', "2.15"

# Use Capistrano for deployment
gem 'capistrano', "2.15", group: :development

group :development, :production do
  gem 'letter_opener'
end
