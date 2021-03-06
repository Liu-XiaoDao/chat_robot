source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use sqlite3 as the database for Active Record
#gem 'sqlite3'
gem 'mysql2'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# 搜索
gem "elasticsearch"
gem "elasticsearch-model"
gem "elasticsearch-rails"

# 部署
gem "capistrano", "~> 3.10"
gem 'capistrano-rails', '~> 1.1'
gem 'capistrano-bundler', '~> 1.1'
gem 'capistrano-rvm',   '~> 0.1'

gem 'will_paginate', '3.1.5'   #分页

#发生异常是发送邮件
gem 'exception_notification'#这个是发生异常后，发送邮件给开发者

#redis
gem 'redis', '~> 4.0', '>= 4.0.1'

#网络请求
gem 'rest-client'
#调试
gem 'pry', '~> 0.11.3'

gem 'chartkick'

gem "rubyXL", '~> 3.3.29'
gem "spreadsheet", "~> 1.1.7"
gem 'roo', "~> 1.13.2"
gem "ruby-progressbar", "~> 1.7.0"
gem "httparty", "~> 0.13.3"

#上传附件
gem "paperclip", "~> 6.0.0"
gem 'ransack', "~> 1.8.8"

gem 'omniauth-ldap'     #ldap域登陆

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :staging do
  gem 'listen', '>= 3.0.5', '< 3.2'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
