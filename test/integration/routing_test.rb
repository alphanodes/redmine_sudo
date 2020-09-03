require File.expand_path '../../test_helper', __FILE__

class RoutingTest < Redmine::RoutingTest
  test 'sudo' do
    should_route 'POST /sudo/toggle' => 'sudos#toggle'
  end
end
