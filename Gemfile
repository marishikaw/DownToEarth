source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '~> 5.2.5'
gem 'sqlite3'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false

# ===【追加】===================================================================
gem 'devise'
gem 'rails-i18n', '~> 5.1'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem "refile", require: "refile/rails", github: 'manfe/refile'
gem "refile-mini_magick"
gem 'ransack'
gem 'news-api'
gem 'bootstrap', '~> 4.5'
gem 'jquery-rails'
gem 'font-awesome-sass', '~> 5.13'
gem 'kaminari', '~> 1.2.1'
gem 'bullet'
gem 'dotenv-rails'
gem 'whenever', require: false

group :production do
  gem 'mysql2'
end
# ==============================================================================

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # ---【追加】-------------
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # ---【追加】-------------
  gem 'rubocop-airbnb'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
