# frozen_string_literal: true

module RedmineSudo
  module Hooks
    class ModelHook < Redmine::Hook::Listener
      def after_plugins_loaded(_context = {})
        return if Rails.version < '6.0'

        RedmineSudo.setup!
      end
    end
  end
end
