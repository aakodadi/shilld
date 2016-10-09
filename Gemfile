source 'https://rubygems.org'


gem 'rails',                    '5.0.0.1'
gem 'puma',                     '3.6.0'
gem 'active_model_serializers', '0.10.2'
gem 'bcrypt',                   '3.1.11'

group :development, :test do
  gem 'sqlite3', '1.3.11'
  gem 'byebug',  '9.0.5', platform: :mri
end

group :development do
  gem 'listen',                '3.1.5'
  gem 'spring',                '1.7.2'
  gem 'spring-watcher-listen', '2.0.0'
end

group :test do
  gem 'minitest-reporters',       '1.1.9'
  gem 'codeclimate-test-reporter', require: nil
end

group :production do
  gem 'pg',   '0.18.4'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
