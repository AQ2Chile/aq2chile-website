source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'jquery-rails'
gem 'haml-rails'
gem 'q2_server_query', path: "/Users/rojo/Dropbox/Dev/Rojo/github/q2_server_query"
gem 'geo_ip', github: 'elfenars/geo_ip'

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'better_errors'
  gem 'binding_of_caller'
end
