require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new(username: "user",
      name: "Example User",
      email: "user@example.com",
      password: 'secure_password',
      password_confirmation: 'secure_password')
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "too should be" do
    @user.password = nil
    @user.password_confirmation = nil
    assert_not @user.valid?
    assert_equal ["can't be blank"],
      @user.errors.messages[:password]
  end

  test "too short password" do
    @user.password = "pass"
    @user.password_confirmation = "pass"
    assert_not @user.valid?
    assert_equal ["is too short (minimum is 6 characters)"],
      @user.errors.messages[:password]
  end

  test "too long password" do
    @user.password = "a" * 73
    @user.password_confirmation = "a" * 73
    assert_not @user.valid?
    assert_equal ["is too long (maximum is 72 characters)"],
      @user.errors.messages[:password]
  end

  test "password confirmation doesn't match password" do
    @user.password = "password"
    assert_not @user.valid?
    assert_equal ["doesn't match Password"],
      @user.errors.messages[:password_confirmation]
  end

  test "valid username format" do
    valid_usernames = [
      "user.name",
      "user_name",
      "user-name",
      "123",
      "USERNAME",
      "---",
      "..."
    ]
    valid_usernames.each do |valid_username|
      @user.username = valid_username
      assert @user.valid?
    end
  end

  test "unvalid username format" do
    unvalid_usernames = [
      "user name",
      "user?name",
      "{username}",
      "[username]",
      "@username"
    ]
    unvalid_usernames.each do |unvalid_username|
      @user.username = unvalid_username
      assert_not @user.valid?
      assert_equal ["is invalid"],
        @user.errors.messages[:username]
    end
  end

  test "username should be" do
    @user.username = nil
    assert_not @user.valid?
    assert_equal ["can't be blank", "is invalid"],
      @user.errors.messages[:username]
  end

  test "username already taken" do
    @user.username = "Einstein"
    assert_not @user.valid?
    assert_equal ["has already been taken"],
      @user.errors.messages[:username]
  end

  test "username too long" do
    @user.username = "a" * 51
    assert_not @user.valid?
    assert_equal ["is too long (maximum is 50 characters)"],
      @user.errors.messages[:username]
  end

  test "name should be" do
    @user.name = nil
    assert_not @user.valid?
    assert_equal ["can't be blank"],
      @user.errors.messages[:name]
  end

  test "name too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
    assert_equal ["is too long (maximum is 50 characters)"],
      @user.errors.messages[:name]
  end

  test "email should be" do
    @user.email = nil
    assert_not @user.valid?
    assert_equal ["can't be blank", "is invalid"],
      @user.errors.messages[:email]
  end

  test "valid email format" do
    valid_emails = [
      "user.name@example.com",
      "user_name@example.com",
      "user-name@example.com",
      "123@example.com",
      "USERNAME@example.com",
      "---@example.com",
      "...@example.com"
    ]
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?
    end
  end

  test "unvalid email format" do
    unvalid_emails = [
      "user.name@example",
      "user_name@@example.com",
      "@example.com",
      "123@example.com@",
      "@USERNAME@example.com",
      "-?-@example.com",
      ".{}.@example.com"
    ]
    unvalid_emails.each do |unvalid_email|
      @user.email = unvalid_email
      assert_not @user.valid?
      assert_equal ["is invalid"],
        @user.errors.messages[:email]
    end
  end

  test "email too long" do
    @user.email = "user_name@example.com" + "a" * 256
    assert_not @user.valid?
    assert_equal ["is too long (maximum is 255 characters)"],
      @user.errors.messages[:email]
  end
end
