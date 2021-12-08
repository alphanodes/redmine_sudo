# frozen_string_literal: true

module RedmineSudo
  VERSION = '1.0.2'

  include RedminePluginKit::PluginBase

  class << self
    private

    def setup
      # Patches
      loader.add_patch %w[ApplicationController
                          UsersController
                          User]

      # Global helpers
      loader.add_global_helper RedmineSudo::Helpers

      # Apply patches and helper
      loader.apply!

      # Load view macros
      loader.load_view_hooks!
    end
  end
end
