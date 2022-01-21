# frozen_string_literal: true
require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  #this is first page layout
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
  end
end