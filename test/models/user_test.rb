require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid? 
  end

  test "email should not be too long" do 
    @user.email = "a" * 244 + "@example.com" 
    assert_not @user.valid?
  end

  test "email should accept valid addresses" do
    @user.email = "rich@fullstack.coach"
    assert @user.valid?
  end

  test "email should reject invalid addresses" do
    @user.email = "adf a"
    assert_not @user.valid?
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present" do
    # default user is valid
    assert @user.password && @user.password_confirmation
    assert_not @user.password == "" && @user.password_confirmation == ""
    assert @user.valid?
    # invalid example
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    # default user's pw is valid length
    assert @user.password.length >= 6 && @user.password_confirmation.length >= 6
    assert @user.valid?
    # invalid example
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end
