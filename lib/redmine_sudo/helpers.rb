# frozen_string_literal: true

module RedmineSudo
  module Helpers
    def toggle_link_info
      admin = User.current.admin?

      { url: toggle_sudo_path(back_url: request.fullpath),
        title: admin ? l(:label_drop_admin_permission) : l(:label_become_admin),
        css: admin ? 'sudo-admin' : 'sudo-user',
        icon: admin ? 'fas_angle-double-down' : 'fas_angle-double-up' }
    end
  end
end
