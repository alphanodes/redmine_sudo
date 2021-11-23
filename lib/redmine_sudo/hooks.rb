# frozen_string_literal: true

module RedmineSudo
  module Hooks
    class RedmineSudoHookListener < Redmine::Hook::ViewListener
      render_on :view_layouts_base_body_bottom, partial: 'sudo/body_bottom'
      render_on :view_my_account_contextual, partial: 'my/sudo_contextual'
    end
  end
end
