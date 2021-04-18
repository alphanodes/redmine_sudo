# frozen_string_literal: true

require File.expand_path '../../../test_helper', __FILE__

module ApiTest
  class UsersTest < Redmine::ApiTest::Base
    fixtures :users, :email_addresses, :groups_users, :roles, :user_preferences,
             :enumerations,
             :projects, :projects_trackers, :enabled_modules,
             :members, :member_roles

    test 'GET /users.xml should return users' do
      get '/users.xml', headers: credentials('admin')

      assert_response :success
      assert_equal 'application/xml', response.media_type
      assert_select 'users' do
        assert_select 'user', User.active.count
      end
    end

    test 'GET /users/:id.xml should return the user' do
      get '/users/2.xml'

      assert_response :success
      assert_select 'user id', text: '2'
      assert_select 'user admin', 0
      assert_select 'user sudoer', 0
    end

    test 'GET /users/:id.xml should return the user with admin info' do
      get '/users/2.xml', headers: credentials('admin')

      assert_response :success
      assert_select 'user id', text: '2'
      assert_select 'user admin', text: 'false'
      assert_select 'user sudoer', text: 'false'

      get '/users/1.xml', headers: credentials('admin')

      assert_response :success
      assert_select 'user id', text: '1'
      assert_select 'user admin', text: 'true'
      assert_select 'user sudoer', text: 'false'
    end

    test 'GET /users/:id.json should return the user' do
      get '/users/2.json'

      assert_response :success
      json = ActiveSupport::JSON.decode response.body
      assert_kind_of Hash, json
      assert_kind_of Hash, json['user']
      assert_equal 2, json['user']['id']
    end
  end
end
