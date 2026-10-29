# frozen_string_literal: true

require File.expand_path '../../test_helper', __FILE__

class I18nTest < RedmineSudo::TestCase
  Additionals.define_i18n_tests self,
                                plugin: 'redmine_sudo',
                                control_string: :label_become_admin,
                                control_english: 'Become administrator'
end
