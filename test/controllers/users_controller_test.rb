require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get users_edit_url
    assert_response :success
  end

  test "should get show" do
    get users_show_url
    assert_response :success
  end

  test "should get leave" do
    get users_leave_url
    assert_response :success
  end

  test "should get my_reviews" do
    get users_my_reviews_url
    assert_response :success
  end

  test "should get my_bookmarks" do
    get users_my_bookmarks_url
    assert_response :success
  end

end
