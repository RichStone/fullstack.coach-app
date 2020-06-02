require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  test 'test flash error appears and disappears again' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {
      session: {
        email: 'nonexistent@mail.com',
        password: 'doesnt matter actually'
      }
    }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

end
