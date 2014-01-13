require 'test_helper'

class BeerStylesControllerTest < ActionController::TestCase
  test "should get indexs" do
    get :indexs
    assert_response :success
  end

end
