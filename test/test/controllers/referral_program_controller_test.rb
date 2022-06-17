require "test_helper"

class ReferralProgramControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get referral_program_home_url
    assert_response :success
  end
end
