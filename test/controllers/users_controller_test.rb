require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.new(username: "user", name: "Example User", email: "user@example.com", password: 'secure_password', password_confirmation: 'secure_password')
    @newton = users(:newton)
  end

  test "should get index" do
    get users_url, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: {
        user: { email: @user.email,
          username: @user.username,
          name: @user.name, password:
          @user.password,
          password_confirmation: @user.password_confirmation
        }
      }, as: :json
    end

    assert_response 201
  end

  test "should not create user if unvalid" do
    assert_no_difference('User.count') do
      post users_url, params: {
        user: { email: @user.email,
          username: @user.username,
          name: @user.name, password:
          @user.password,
          password_confirmation: "password"
        }
      }, as: :json
    end

    assert_response 422
  end

  test "should show user" do
    get user_url(@newton.username), as: :json
    assert_response :success
  end

  test "should update user" do
    patch user_url(@newton.username), params: {
      user: { email: "newton@example.com",
        name: "Newton",
        password: 'appleinthehead',
        password_confirmation: 'appleinthehead',
        username: 'isaac.newton'
      }
    }, as: :json
    assert_response 200
  end

  test "should not update user if unvalid" do
    patch user_url(@newton.username), params: {
      user: { email: "newton@example.com",
        name: "Newton",
        password: 'appleinthehead',
        password_confirmation: 'password',
        username: 'isaac.newton'
      }
    }, as: :json
    assert_response 422
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@newton.username), as: :json
    end

    assert_response 204
  end
end
