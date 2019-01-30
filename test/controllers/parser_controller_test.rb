require 'test_helper'

class ParserControllerTest < ActionDispatch::IntegrationTest
  test "should get rubysec" do
    get parser_rubysec_url
    assert_response :success
  end

end
