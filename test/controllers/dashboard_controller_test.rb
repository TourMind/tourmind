# frozen_string_literal: true

require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test 'should get users' do
    get dashboard_users_url
    assert_response :success
  end

  test 'should get sites' do
    get dashboard_sites_url
    assert_response :success
  end

  test 'should get hotels' do
    get dashboard_hotels_url
    assert_response :success
  end

  test 'should get restaurants' do
    get dashboard_restaurants_url
    assert_response :success
  end
end
