# frozen_string_literal: true

module RedmineSudo
  VERSION = '1.0.4'

  include RedminePluginKit::PluginBase

  class << self
    private

    def setup
      # Patches
      loader.add_patch %w[ApplicationController
                          UsersController
                          Mailer
                          User]

      loader.add_patch 'UserQuery' if Redmine::VERSION.to_s >= '5.1'

      # Global helpers
      loader.add_global_helper RedmineSudo::Helpers

      # Apply patches and helper
      loader.apply!

      # Load view macros
      loader.load_view_hooks!
    end
  end
end
