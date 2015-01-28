source 'https://rubygems.org'
#ruby '2.1.5'

# Standard Rails gems
#gem 'rails', '4.1.8'
gem 'rails', '4.2'
#gem 'sass-rails', '4.0.4'
#gem 'uglifier', '2.5.3'
#gem 'coffee-rails', '4.1.0'
#gem 'jquery-rails', '3.1.2'
#gem 'turbolinks', '2.5.2'
####gem 'jbuilder', '2.2.5'
gem 'jbuilder', '~> 2.0'
gem 'bcrypt', '3.1.9'

# Necessary for Windows OS (won't install on *nix systems)
#gem 'tzinfo-data', platforms: [:mingw, :mswin]

# Kaminari: https://github.com/amatsuda/kaminari
gem 'kaminari', '0.16.1'

# Friendly_id: https://github.com/norman/friendly_id
gem 'friendly_id', '5.0.4'

# Font-awesome: https://github.com/FortAwesome/font-awesome-sass
#gem 'font-awesome-sass', '4.2.2'

# Bootstrap 3: https://github.com/twbs/bootstrap-sass
#gem 'bootstrap-sass', '3.3.1.0'

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring', group: :development

# Figaro: https://github.com/laserlemon/figaro
#group :development, :test do
#  gem 'figaro', '1.0.0'
#end

# sort of the same thing as the figaro gem and 'secrets.yml' - do we really need it?? we should make a choice ... see:
# https://shellycloud.com/documentation/environment_variables
gem "rails_config"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
#  gem 'web-console', '~> 2.0'
end

# SQLite 3
group :development, :test do
  gem 'sqlite3', '1.3.10'
end

# Simple_form: https://github.com/plataformatec/simple_form
#gem 'simple_form'

# Devise: https://github.com/plataformatec/devise
gem 'devise', '3.4.1'

# Redcarpet: https://github.com/vmg/redcarpet
gem 'redcarpet', '3.2.0'

# Use mysql as the database for Active Record
gem 'mysql2'

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

#group :development, :test do
#  gem 'rspec-rails', '~> 3.0.0'
#end

group :development, :test do
  # https://github.com/rweng/pry-rails
  gem 'pry-rails'

  gem 'pry-doc'

  # https://github.com/michaeldv/awesome_print
  gem 'awesome_print'
end

#group :development do
#  gem "better_errors"
#  gem "binding_of_caller"
#end