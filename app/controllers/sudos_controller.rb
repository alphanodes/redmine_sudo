# frozen_string_literal: true

class SudosController < ApplicationController
  before_action :require_login

  def toggle
    return render_403 unless User.current.sudoer?

    if User.current.admin?
      # Dropping admin permission: always return home, because the page the
      # toggle was triggered from often denies access to non-admins.
      User.current.update_admin! false
      redirect_to home_path
    else
      # Escalating to admin requires a password confirmation and returns to the
      # page the toggle was triggered from (passed as back_url).
      return unless require_sudo_mode

      User.current.update_admin! true
      redirect_back_or_default home_path
    end
  end
end
