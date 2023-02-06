# frozen_string_literal: true

module RedmineSudo
  module Patches
    module MailerPatch
      extend ActiveSupport::Concern

      included do
        # NOTE: overwritten, because we cannot modify users scope
        # TODO: this should be checked for redmine changes
        def self.deliver_account_activation_request(new_user)
          # Send the email to all active administrators
          users = User.sudoer.active
          users.each do |user|
            account_activation_request(user, new_user).deliver_later
          end
        end

        # NOTE: overwritten, because we cannot modify users scope
        # TODO: this should be checked for redmine changes
        # rubocop: disable Style/OptionHash
        def self.deliver_settings_updated(sender, changes, options = {})
          return if changes.blank?

          changes = changes.map(&:to_s)
          options[:remote_ip] ||= sender.remote_ip

          users = User.sudoer.active.to_a
          users.each do |user|
            settings_updated(user, sender, changes, options).deliver_later
          end
        end
        # rubocop: enable Style/OptionHash
      end
    end
  end
end
