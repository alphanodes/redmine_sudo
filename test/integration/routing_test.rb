# frozen_string_literal: true

require File.expand_path '../test_helper', __dir__

class RoutingTest < Redmine::RoutingTest
  test 'sudo' do
    should_route 'POST /sudo/toggle' => 'sudos#toggle'
  end
end
