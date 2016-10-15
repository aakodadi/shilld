require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @newton = users(:newton)
    @post = Post.new(body: "This is a test post", user: @newton)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "body must be" do
    @post.body = nil
    assert_not @post.valid?
    assert_equal ["can't be blank"],
      @post.errors.messages[:body]
  end

  test "too long body" do
    @post.body = "a" * 5001
    assert_not @post.valid?
    assert_equal ["is too long (maximum is 5000 characters)"],
      @post.errors.messages[:body]
  end
end
