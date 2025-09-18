require "test_helper"

class ExpertRatingsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get expert_ratings_create_url
    assert_response :success
  end
end
