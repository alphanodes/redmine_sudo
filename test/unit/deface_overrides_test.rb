# frozen_string_literal: true

require File.expand_path '../../test_helper', __FILE__

# The only place a drifted deface anchor shows up: deface logs an error and
# applies the override anyway, so a view patch that no longer matches its target
# stays silent otherwise. The prefix is what ties an override to this plugin.
class DefaceOverridesTest < RedmineSudo::TestCase
  def test_all_deface_overrides_have_valid_hashes
    assert_deface_overrides_valid name_prefix: 'sudo'
  end
end
