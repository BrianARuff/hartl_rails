require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  before_count = User.count
  test "should fail to post a user" do
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" }
      }
    end
    after_count = User.count
    assert_equal(before_count, after_count)
    assert_template "users/new"
    assert_select "div#error_explanation"
    assert_select "div.alert"
    assert_select "div.alert-danger"
  end

  test "valid signup information" do
    before_count = User.count
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {  name: "Test User", email:
          "test_user@gmail.com", password: "foobar", password_confirmation:
                                              "foobar" } }
      after_count = User.count
      assert before_count < after_count
      follow_redirect!
      assert_template "users/show"
      assert_not(flash[:danger])
      assert(flash[:success])
    end
  end
end