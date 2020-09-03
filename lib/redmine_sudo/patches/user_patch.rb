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
        # only used for api
        def update_sudoer
          self.sudoer = true if admin? && !sudoer? && (new_record? || admin_changed?)
        end

        def update_admin!(value)
          User.where(id: id).update_all admin: value, updated_on: Time.zone.now
        end
      end
    end
  end
end
