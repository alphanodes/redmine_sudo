# frozen_string_literal: true

require File.expand_path '../../test_helper', __FILE__

class UsersControllerTest < RedmineSudo::ControllerTest
  fixtures :users, :email_addresses, :groups_users, :roles, :user_preferences,
           :enumerations,
           :projects, :projects_trackers, :enabled_modules,
           :members, :member_roles

  def setup
    User.current = nil
  end

  def test_create_user_with_sudo_but_without_admin_permission
    User.find(1).update_columns(sudoer: true, admin: false)

    @request.session[:user_id] = 1
    assert_no_difference 'User.count' do
      post :create,
           params: { user: { firstname: 'John',
                             lastname: 'Doe',
                             login: 'jdoe',
                             password: 'secret123',
                             password_confirmation: 'secret123',
                             mail: 'jdoe@gmail.com',
                             sudoer: true } }
    end
  end

  def test_edit_sudoer_without_admin
    User.find(2).update_columns(sudoer: true)

    @request.session[:user_id] = 2
    get :edit, params: { id: 2 }

    assert User.find(2).sudoer?
    assert_response :forbidden
  end

  # only possible with api change
  def test_edit_non_sudoer_but_admin
    @request.session[:user_id] = 1

    get :edit, params: { id: 1 }
    assert_response :success
    assert_select 'input#user_sudoer[disabled=disabled]'
    assert_select 'input#user_admin', count: 0

    get :edit, params: { id: 2 }
    assert_response :success
    assert_select 'input#user_sudoer[disabled=disabled]', count: 0
    assert_select 'input#user_admin', count: 0
  end
end
