# frozen_string_literal: true

require File.expand_path '../../test_helper', __FILE__

class MyControllerTest < RedmineSudo::ControllerTest
  fixtures :users, :email_addresses, :user_preferences, :roles, :projects, :members, :member_roles,
           :issues, :issue_statuses, :trackers, :enumerations, :custom_fields, :auth_sources, :queries, :enabled_modules,
           :journals

  def setup
    User.current = nil
  end

  def test_index_with_sudo_link_for_sudoer
    User.find(1).update_attribute :sudoer, true
    @request.session[:user_id] = 1
    get :account

    assert_response :success
    assert_select 'a.sudo-link'
  end

  def test_index_without_sudo_link_for_non_sudoer
    @request.session[:user_id] = 2
    get :index

    assert_response :success
    assert_select 'a.sudo-link', count: 0
  end
end
