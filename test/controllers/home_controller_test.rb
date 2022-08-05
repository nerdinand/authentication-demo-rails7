# frozen_string_literal: true

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get home_url
    assert_response :success
  end
end
