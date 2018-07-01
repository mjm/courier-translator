source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in courier-translator.gemspec
gemspec

gem 'puma'

group :development do
  gem 'rerun'
end

group :development, :test do
  gem 'bundler', '~> 1.16'
  gem 'rake', '~> 10.0'
end

group :test do
  gem 'rack-test'
  gem 'rspec', '~> 3.0'
end
