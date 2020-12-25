module RedmineSudo
  module Patches
    module ApplicationControllerPatch
      extend ActiveSupport::Concern

      included do
        prepend InstanceOverwriteMethods
        before_action :disable_admin
      end

      module InstanceOverwriteMethods
        def user_setup
          super

          # change to admin, but do not save it (just for this request)
          User.current.admin = true if User.current.sudoer? && api_request?
        end

        # for all sudoer admin should be disabled, if sudo_mode is inactive
        def disable_admin
          return if api_request? || Redmine::SudoMode.active?

          user = User.current
          return unless user.logged? && user.admin? && user.sudoer?

          user.update_columns admin: false, updated_on: Time.zone.now
        end
      end
    end
  end
end
