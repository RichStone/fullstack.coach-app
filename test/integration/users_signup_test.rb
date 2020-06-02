require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: {
          name: "",
          email: "invalid@email",
          password: "short",
          password_confirmation: "wrong"
        }
      }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do 
      post users_path, params: {
        user: {
          name: "RIch smaple",
          email: "valid@mail.com",
          password: "goodlength",
          password_confirmation: "goodlength"
        }
      }
    end
    follow_redirect!
    assert_template 'users/show'
  end

end