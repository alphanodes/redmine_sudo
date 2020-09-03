module RedmineSudo
  module Patches
    module UsersControllerPatch
      extend ActiveSupport::Concern

      included do
        helper :sudo_users
        include SudoUsersHelper
      end
    end
  end
end
