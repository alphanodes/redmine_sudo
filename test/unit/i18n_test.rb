# frozen_string_literal: true

require File.expand_path '../../test_helper', __FILE__

class I18nTest < RedmineSudo::TestCase
  include Redmine::I18n

  def setup
    User.current = nil
  end

  def teardown
    set_language_if_valid 'en'
  end

  def test_valid_languages
    assert_kind_of Array, valid_languages
    assert_kind_of Symbol, valid_languages.first
  end

  def test_locales_validness
    assert_locales_validness plugin: 'redmine_sudo',
                             file_cnt: 9,
                             locales: %w[pt-BR de es fr it ja ru zh],
                             control_string: :label_become_admin,
                             control_english: 'Become Administrator'
  end
end
