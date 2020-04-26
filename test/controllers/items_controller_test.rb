require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get items_search_url
    assert_response :success
  end

  test "should get select_genre" do
    get items_select_genre_url
    assert_response :success
  end

  test "should get ranking" do
    get items_ranking_url
    assert_response :success
  end

end
