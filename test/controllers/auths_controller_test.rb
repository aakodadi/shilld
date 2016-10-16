require 'test_helper'

class AuthsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @newton = users(:newton)
  end

  test "should authenticate and unauthenticate" do
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

end
