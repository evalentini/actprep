require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  test "should get record" do
    get :record
    assert_response :success
  end

end
