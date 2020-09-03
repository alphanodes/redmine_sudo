class SudosController < ApplicationController
  before_action :require_login
  require_sudo_mode :toggle, if: !User.current.admin?

  def toggle
    if User.current.sudoer?
      User.current.update_admin! !User.current.admin?
      redirect_back_or_default controller: 'welcome', action: 'index'
    else
      render_403
    end
  end
end
