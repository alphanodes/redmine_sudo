# frozen_string_literal: true

module RedmineSudo
  VERSION = '1.0.1'

  class << self
    def setup
      # Patches
      ApplicationController.include RedmineSudo::Patches::ApplicationControllerPatch
      UsersController.include RedmineSudo::Patches::UsersControllerPatch
      User.include RedmineSudo::Patches::UserPatch

      # Global Helpers
      ActionView::Base.include RedmineSudo::Helpers

      # Hooks
      RedmineSudo::Hooks
    end
  end
end
