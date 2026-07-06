# frozen_string_literal: true

module RedmineSudo
  module Helpers
    def toggle_link_info
      { url: toggle_sudo_path(back_url: request.fullpath),
        title: User.current.admin? ? l(:label_drop_admin_permission) : l(:label_become_admin),
        icon: 'shield-check' }
    end
  end
end
