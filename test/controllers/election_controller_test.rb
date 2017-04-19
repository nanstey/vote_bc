require 'test_helper'

class ElectionControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get election_show_url
    assert_response :success
  end

end
