require "test_helper"

class PublicControllerTest < ActionDispatch::IntegrationTest
  test "should get initialpage" do
    get public_initialpage_url
    assert_response :success
  end
end
