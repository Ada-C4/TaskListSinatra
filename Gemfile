# A sample Gemfile
source "https://rubygems.org"
ruby "2.2.3"

gem "sinatra"

group :development do
  gem "sqlite3"
  gem "rspec"
  gem "pry"
end


group :production do
  if ENV["DATABASE_URL"]
    gem "pg"
  end
end
