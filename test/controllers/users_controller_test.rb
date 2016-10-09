require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.new(username: "user", email: "user@example.com", password: 'secure_password', password_confirmation: 'secure_password')
    @newton = users(:newton)
  end

  test "should get index" do
    get users_url, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: @user.email, password: @user.password, password_confirmation: @user.password_confirmation, username: @user.username } }, as: :json
    end

    assert_response 201
  end

  test "should show user" do
    get user_url(@newton), as: :json
    assert_response :success
  end

  test "should update user" do
    patch user_url(@newton), params: { user: { email: "newton@example.com", password: 'appleinthehead', password_confirmation: 'appleinthehead', username: 'isaac.newton' } }, as: :json
    assert_response 200
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@newton), as: :json
    end

    assert_response 204
  end
end
