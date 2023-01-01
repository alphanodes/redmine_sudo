# frozen_string_literal: true

require_relative '../test_helper'

class RoutingTest < Redmine::RoutingTest
  test 'sudo' do
    should_route 'POST /sudo/toggle' => 'sudos#toggle'
  end
end
