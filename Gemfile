source "https://rubygems.org"

ruby "3.4.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]

gem "phlex-rails", "~> 2.3"
gem "view_component"
gem "stimulus-rails"
# App specific
gem "slim-rails"
gem "csv"
gem "motor-admin", "~> 0.4"
# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
gem "barby"
gem "trilogy"
gem "ruby-units"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "annotate"
  gem "debug", platforms: %i[ mri windows ]
  gem "dotenv-rails", "~> 3"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem "html2slim", github: "slim-template/html2slim"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  # gem "capybara"
  # gem "selenium-webdriver"
end
