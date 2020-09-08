require_dependency 'project' # @see https://www.redmine.org/issues/11035
require_dependency 'principal'
require_dependency 'user'

module RedmineSudo
  module Patches
    module UserPatch
      extend ActiveSupport::Concern

      included do
        include InstanceMethods

        # for api usage
        before_save :update_sudoer

        safe_attributes 'sudoer', if: ->(user, current_user) { current_user.admin? && user != current_user }
      end

      module InstanceMethods
        def update_sudoer
          return if sudoer? || !admin?

          # if suoder is disabled, admin is also disabled
          if sudoer_changed? && !admin_changed?
            self.admin = false
          elsif new_record? || admin_changed?
            # only used for api
            self.sudoer = true
          end
        end

        def update_admin!(value)
          User.where(id: id).update_all admin: value, updated_on: Time.zone.now
        end
      end
    end
  end
end
