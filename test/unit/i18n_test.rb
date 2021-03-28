# frozen_string_literal: true

require File.expand_path '../test_helper', __dir__

class I18nTest < RedmineSudo::TestCase
  include Redmine::I18n

  def setup
    User.current = nil
  end

  def teardown
    set_language_if_valid 'en'
  end

  def test_valid_languages
    assert valid_languages.is_a?(Array)
    assert valid_languages.first.is_a?(Symbol)
  end

  def test_locales_validness
    lang_files_count = Dir[Rails.root.join('plugins/redmine_sudo/config/locales/*.yml')].size
    assert_equal lang_files_count, 9
    valid_languages.each do |lang|
      assert set_language_if_valid(lang)
      case lang.to_s
      when 'en'
        assert_equal 'Become Administrator', l(:label_become_admin)
      when 'pt-BR', 'de', 'es', 'fr', 'it', 'ja', 'ru', 'zh'
        assert_not l(:label_become_admin) == 'Become Administrator', lang
      end
    end

    set_language_if_valid('en')
  end
end
