# frozen_string_literal: true

module RedmineSudo
  class << self
    def setup
      # Patches
      ApplicationController.include RedmineSudo::Patches::ApplicationControllerPatch
      UsersController.include RedmineSudo::Patches::UsersControllerPatch
      User.include RedmineSudo::Patches::UserPatch

      # Hooks
      require_dependency 'redmine_sudo/hooks'

      # Global Helpers
      ActionView::Base.include RedmineSudo::Helpers
    end
  end
end
