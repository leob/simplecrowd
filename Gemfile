source 'https://rubygems.org'

ruby '2.4.6'

gem 'rails', '4.2'
gem 'responders', '~> 2.0'
gem 'bcrypt', '3.1.9'

gem "paperclip", "~> 4.2"
gem 'kaminari', '0.16.1'
gem 'draper', '~> 1.3'
gem 'money-rails'
gem "interactor-rails", "~> 2.0"
gem 'rails-i18n', '~> 4.0.0'

# needed to get I18N url-based locale switching to work, see comments in config/routes.rb
gem 'routing-filter'

# sort of the same thing as the figaro gem and 'secrets.yml' - do we really need it?? we should make a choice ... see:
# https://shellycloud.com/documentation/environment_variables
gem "rails_config"

gem 'devise', '3.4.1'

# Use mysql as the database for Active Record
gem 'mysql2'

# IN PLACE EDITING, see: https://github.com/bernat/best_in_place
#gem 'best_in_place', '~> 3.0.1'

# Rails 12factor for Heroku: https://github.com/heroku/rails_12factor
group :production do
  gem 'rails_12factor'
end

# PostgreSQL gem for Heroku
group :production do
  gem 'pg'
end

# Unicorn: http://unicorn.bogomips.org
group :production do
  gem 'unicorn'
end

# Paperclip image storage on Amazon S3
group :production do
  gem 'aws-sdk', '~> 1.5.7'
end

gem 'spring', group: :development

group :development, :test do
  gem 'sqlite3', '1.3.10'
end

group :test do
  gem 'capybara'
  gem 'minitest'
  gem 'minitest-capybara'
  gem 'minitest-rails-capybara'
  gem 'minitest-reporters'
  gem 'guard-minitest',     '2.3.1'
  gem "mocha"
end

# Gems not (currently) used

# Redcarpet: https://github.com/vmg/redcarpet
##gem 'redcarpet', '3.2.0'

# Simple_form: https://github.com/plataformatec/simple_form
#gem 'simple_form'
#gem 'jbuilder', '~> 2.0'
#gem 'friendly_id', '5.0.4'

#group :development, :test do
#  gem 'figaro', '1.0.0'
#end

# group :development, :test do
#   # Call 'byebug' anywhere in the code to stop execution and get a debugger console
#   gem 'byebug'
#
#   # Access an IRB console on exception pages or by using <%= console %> in views
# #  gem 'web-console', '~> 2.0'
# end

#group :development, :test do
#  gem 'rspec-rails', '~> 3.0.0'
#end

# group :development, :test do
#   # https://github.com/rweng/pry-rails
#   gem 'pry-rails'
#
#   gem 'pry-doc'
#
#   # https://github.com/michaeldv/awesome_print
#   gem 'awesome_print'
# end

#group :development do
#  gem "better_errors"
#  gem "binding_of_caller"
#end
