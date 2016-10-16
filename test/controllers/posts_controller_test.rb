require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    login_as(User.new(username: 'newton', password: 'appleinthehead'))
  end

  test "should not get index if not authenticated" do
    get posts_url, as: :json
    assert_response :unauthorized
  end

  test "should get index" do
    get posts_url, headers: get_headers, as: :json
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post posts_url, headers: get_headers,
        params: { post: { body: @post.body } }, as: :json
    end

    assert_response 201
  end

  test "should not create post if not authenticated" do
    assert_no_difference('Post.count') do
      post posts_url, params: { post: { body: @post.body } }, as: :json
    end

    assert_response :unauthorized
  end

  test "should not create post if unvalid" do
    assert_no_difference('Post.count') do
      post posts_url, headers: get_headers,
        params: { post: { body: nil } }, as: :json
    end

    assert_response 422
  end

  test "should show post" do
    get post_url(@post), headers: get_headers, as: :json
    assert_response :success
  end

  test "should not show post if not authenticated" do
    get post_url(@post), as: :json
    assert_response :unauthorized
  end

  test "should update post" do
    patch post_url(@post), headers: get_headers,
      params: { post: { body: @post.body } }, as: :json
    assert_response 200
  end

  test "should not update post if not authenticated" do
    patch post_url(@post), params: { post: { body: @post.body } }, as: :json
    assert_response :unauthorized
  end

  test "should not update post if not authenticated as author" do
    @post = posts(:two)
    patch post_url(@post), headers: get_headers,
      params: { post: { body: @post.body } }, as: :json
    assert_response :unauthorized
  end

  test "should not update post if unvalid" do
    patch post_url(@post), headers: get_headers,
      params: { post: { body: nil } }, as: :json
    assert_response 422
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post), headers: get_headers, as: :json
    end

    assert_response 204
  end

  test "should not destroy post if not authenticated" do
    assert_no_difference('Post.count') do
      delete post_url(@post), as: :json
    end

    assert_response :unauthorized
  end

  test "should not destroy post if not authenticated as author" do
    @post = posts(:two)
    assert_no_difference('Post.count') do
      delete post_url(@post), headers: get_headers, as: :json
    end

    assert_response :unauthorized
  end
end
