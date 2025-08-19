# frozen_string_literal: true

if ENV['COVERAGE']
  require 'simplecov'
  require 'simplecov-rcov'

  SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter[SimpleCov::Formatter::HTMLFormatter,
                                                              SimpleCov::Formatter::RcovFormatter]

  SimpleCov.start :rails do
    add_filter 'init.rb'
    root File.expand_path "#{File.dirname __FILE__}/.."
  end
end

require File.expand_path "#{File.dirname __FILE__}/../../../test/test_helper"
require File.expand_path "#{File.dirname __FILE__}/../../additionals/test/global_test_helper"

module RedmineSudo
  module TestHelper
    include Additionals::GlobalTestHelper

    def prepare_tests; end
  end

  class ControllerTest < Redmine::ControllerTest
    include RedmineSudo::TestHelper

    fixtures :all
  end

  class TestCase < ActiveSupport::TestCase
    include RedmineSudo::TestHelper

    fixtures :all
  end
end
