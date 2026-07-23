# frozen_string_literal: true

require_dependency 'project' # @see https://www.redmine.org/issues/11035
require_dependency 'principal'
require_dependency 'user'

module RedmineSudo
  module Patches
    module UserPatch
      extend ActiveSupport::Concern

      included do
        prepend InstanceOverwriteMethods
        include InstanceMethods

        scope :sudoer, -> { where sudoer: true }

        # for api usage
        before_save :update_sudoer

        safe_attributes 'sudoer', if: ->(user, current_user) { current_user.admin? && user != current_user }
      end

      module InstanceOverwriteMethods
        # NOTE: overwritten, because we cannot modify users scope
        # TODO: this should be checked for redmine changes
        def deliver_security_notification
          # Skip during the first plugin migration boot: the `sudoer` column may
          # not exist yet while other plugins trigger a User.anonymous save on load.
          return unless has_attribute? :sudoer

          message = security_notification_message
          return unless message

          options = {
            field: :field_admin,
            value: login,
            title: :label_user_plural,
            url: { controller: 'users', action: 'index' },
            message: message
          }

          users = User.sudoer.active.to_a
          Mailer.deliver_security_notification users, User.current, options
        end

        # admin? has been replaced with sudoer?
        def must_activate_twofa?
          rc = super
          return rc if rc

          !twofa_active? && Setting.twofa_required_for_administrators? && sudoer?
        end
      end

      module InstanceMethods
        # Returns the security notification message key for the current save, or nil
        # when no notification should be delivered.
        def security_notification_message
          if (sudoer? && saved_change_to_id? && active?) ||     # newly created admin
             (sudoer? && saved_change_to_sudoer? && active?) || # regular user became admin
             (sudoer? && saved_change_to_status? && active?)    # locked admin became active again
            :mail_body_security_notification_add
          elsif (sudoer? && destroyed? && active?) ||               # active admin user was deleted
                (!sudoer? && saved_change_to_sudoer? && active?) || # admin is no longer admin
                (sudoer? && saved_change_to_status? && !active?)    # admin was locked
            :mail_body_security_notification_remove
          end
        end

        def update_sudoer
          # Skip during the first plugin migration boot: the `sudoer` column may
          # not exist yet while other plugins trigger a User.anonymous save on load.
          return unless has_attribute? :sudoer
          return if sudoer? || !admin?

          # if suoder is disabled, admin is also disabled
          if will_save_change_to_sudoer? && !will_save_change_to_admin?
            self.admin = false
          elsif new_record? || will_save_change_to_admin?
            # only used for api
            self.sudoer = true
          end
        end

        def update_admin!(value)
          User.where(id: id).update_all admin: value, updated_on: Time.current
        end
      end
    end
  end
end
