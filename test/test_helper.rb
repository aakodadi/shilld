ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_as(user)
    post auth_url,
      params: { user: {
          username: user.username,
          password: user.password
        }
      }, as: :json
      user = JSON.parse(@response.body)
      @headers = {
        'Authorization' => %(Token token="#{user["auth_token"]}", username="#{user["username"]}")
      }
      @current_user = User.find_by(username: user["username"])
  end

  def get_headers
    @headers
  end

  def current_user
    @current_user
  end
end
