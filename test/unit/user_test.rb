require File.expand_path '../../test_helper', __FILE__

class UserTest < RedmineSudo::TestCase
  fixtures :users, :groups_users, :email_addresses,
           :members, :projects, :roles, :member_roles, :auth_sources,
           :trackers, :issue_statuses,
           :projects_trackers,
           :watchers,
           :issue_categories, :enumerations, :issues,
           :journals, :journal_details,
           :enabled_modules,
           :tokens, :user_preferences

  def test_should_user_gets_correct_sudoer_at_creation
    user = User.generate! admin: true
    assert user.sudoer?
    assert user.admin?
    assert user.can_be_admin?

    user = User.generate! admin: false
    assert_not user.sudoer?
    assert_not user.admin?
    assert_not user.can_be_admin?

    user = User.generate! sudoer: true
    assert user.sudoer?
    assert_not user.admin?
    assert user.can_be_admin?
  end

  def test_should_user_keeps_sudoer_on_update_if_he_should
    user = User.generate! admin: true
    user.update_admin! false
    user.reload
    assert_not user.admin?
    assert user.sudoer?

    user = User.generate! sudoer: true
    user.update_admin! false
    user.reload
    assert_not user.admin?
    assert user.sudoer?

    # doesn't change #admin, so #sudoer doesn't change
    user.update_attribute(:firstname, 'John')
    user.reload
    assert_not user.admin?
    assert user.sudoer?
  end

  def test_should_user_gets_correct_sudoer_when_updating_admin_boolean
    user = User.generate! admin: true
    # updates #admin, so #sudoer should be updated accordingly
    user.update_attribute :admin, false
    user.reload
    assert_not user.admin?
    assert user.sudoer?

    user.update_attribute :admin, true
    user.reload
    assert user.admin?
    assert user.sudoer?
  end

  def test_sets_a_new_updated_on_date_after_admin_changed
    user = User.generate! admin: true
    user.update_attribute :updated_on, nil
    user.reload
    assert_nil user.updated_on

    user = User.generate! sudoer: true
    user.update_attribute :updated_on, nil
    user.reload
    assert_nil user.updated_on

    user.update_admin! false
    user.reload
    assert_not_nil user.updated_on
  end
end
