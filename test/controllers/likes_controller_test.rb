require 'test_helper'

class LikesControllerTest < ActionController::TestCase
  test "should get AddLike" do
    get :AddLike
    assert_response :success
  end

end
