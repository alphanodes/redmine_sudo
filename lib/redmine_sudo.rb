# frozen_string_literal: true

module RedmineSudo
  VERSION = '1.0.1'

  class << self
    def setup
      loader = AdditionalsLoader.new plugin_id: 'redmine_sudo'

      # Patches
      loader.add_patch %w[ApplicationController
                          UsersController
                          User]

      # Global helpers
      loader.add_global_helper RedmineSudo::Helpers

      # Apply patches and helper
      loader.apply!
    end
  end
end
