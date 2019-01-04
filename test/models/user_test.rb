require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Brian Ruff", email: "brff19@gmail.com", password:
        "foobar", password_confirmation: "foobar")
  end

  test "it should be valid" do
     assert_equal(@user.valid?, true)
  end

  test "name should be present" do
    @user.name = "     "
    assert_not(@user.valid?)
  end

  test "email should be present" do
    @user.email = "     "
    assert_not(@user.valid?)
  end

  test "name should not be too long" do
    @user.email = "a"*51+"@email.com"
    assert_not(@user.valid?)
  end

  test "email should not be too long" do
    @user.name = "a"*244+"@example.com"
    assert_not(@user.valid?)
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org
first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert(@user.valid?, "#{address.inspect} should be valid")
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example
. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not(@user.valid?, "#{address.inspect} should not be valid")
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = duplicate_user.email.upcase
    @user.save
    assert_not(duplicate_user.valid?)
  end

  test "email address only includes lower cased characters upon saving" do
    mixed_case_user_email = "BrFf@gmail.com"
    @user.email = mixed_case_user_email
    @user.save
    assert_equal(@user.email, @user.email.downcase)
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not(@user.valid?)
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not(@user.valid?)
  end
end