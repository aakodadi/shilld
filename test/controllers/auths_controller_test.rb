require 'test_helper'

class AuthsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @newton = users(:newton)
  end

  test "should authenticate and unauthenticate with username" do
    post auth_url,
      params: { user: {
          username: @newton.username,
          password: 'appleinthehead'
        }
      }, as: :json
    assert_response :success
    user = JSON.parse(@response.body)
    assert_equal @newton.username, user["username"]
    delete auth_url,
      headers: {
        'Authorization' => %(Token token="#{user["auth_token"]}", username="#{@newton.username}")
      }
    assert_response :success
  end

  test "should authenticate and unauthenticate with email" do
    post auth_url,
      params: { user: {
          email: @newton.email,
          password: 'appleinthehead'
        }
      }, as: :json
    assert_response :success
    user = JSON.parse(@response.body)
    assert_equal @newton.username, user["username"]
    delete auth_url,
      headers: {
        'Authorization' => %(Token token="#{user["auth_token"]}", username="#{@newton.username}")
      }
    assert_response :success
  end

  test "should not authenticate with wrong password" do
    post auth_url,
      params: { user: {
          username: @newton.username,
          password: 'newton'
        }
      }, as: :json
    assert_response :unauthorized
  end

  test "should not authenticate with wrong username" do
    post auth_url,
      params: { user: {
          username: "newtonn",
          password: 'appleinthehead'
        }
      }, as: :json
    assert_response :unprocessable_entity
  end

  test "should not authenticate with wrong email" do
    post auth_url,
      params: { user: {
          eamil: "newtonn@example.com",
          password: 'appleinthehead'
        }
      }, as: :json
    assert_response :unprocessable_entity
  end

end
