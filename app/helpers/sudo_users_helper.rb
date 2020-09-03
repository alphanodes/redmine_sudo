module SudoUsersHelper
  def sort_update(criteria, sort_name = nil)
    return super unless controller_name == 'users' && action_name == 'index'

    criteria.map! { |x| x == 'admin' ? 'sudoer' : x }
    super
  end

  # Hacked render_api_custom_values to add plugin values to user api
  def render_api_custom_values(custom_values, api)
    rc = super
    api.sudoer @user.sudoer? if @user.present? && (User.current.admin? || User.current == @user)

    rc
  end
end
