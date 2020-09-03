# This file is a part of redmine_passwords,
# a passwords managing plugin for Redmine.
#
# Copyright (c) 2015-2020 AlphaNodes GmbH
# https://alphanodes.com

module RedmineSudo
  module Helpers
    def toggle_link_info
      admin = User.current.admin?

      { url: toggle_sudo_path(back_url: url_for(request.params)),
        title: admin ? l(:label_drop_admin_permission) : l(:label_become_admin),
        css: admin ? 'sudo-admin' : 'sudo-user',
        icon: admin ? 'fas_angle-double-down' : 'fas_angle-double-up' }
    end
  end
end
