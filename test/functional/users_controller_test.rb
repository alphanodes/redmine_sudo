require File.expand_path '../../test_helper', __FILE__

class UsersControllerTest < RedmineSudo::ControllerTest
  fixtures :users, :email_addresses, :groups_users, :roles, :user_preferences,
           :enumerations,
           :projects, :projects_trackers, :enabled_modules,
           :members, :member_roles

  def test_create_user_with_sudo_permission
    @request.session[:user_id] = 1
    assert_difference 'User.count' do
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

  def test_edit_sudoer
    User.find(1).update_attribute :sudoer, true
    @request.session[:user_id] = 1
    get :edit,
        params: { id: 1 }
    assert_select 'input#user_sudoer'
    assert_select 'input#user_admin', count: 0
  end

  def test_edit_non_sudoer
    @request.session[:user_id] = 2
    get :edit,
        params: { id: 1 }
    assert_select 'input#user_sudoer', count: 0
    assert_select 'input#user_admin', count: 0
  end
end
