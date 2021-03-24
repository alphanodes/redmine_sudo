# frozen_string_literal: true

raise 'Please activate sudo_mode in your configuration.yml, which is required for this plugin' unless Redmine::Configuration['sudo_mode']

Redmine::Plugin.register :redmine_sudo do
  name 'Redmine sudo'
  url 'https://github.com/alphanodes/redmine_sudo'
  description 'Sudo functionality for user to get admin permission'
  version RedmineSudo::VERSION
  author 'AlphaNodes GmbH'
  author_url 'https://alphanodes.com/'

  begin
    requires_redmine_plugin :additionals, version_or_higher: '3.0.0'
  rescue Redmine::PluginNotFound
    raise 'Please install additionals plugin (https://github.com/alphanodes/additionals)'
  end

  menu :account_menu, :sudo, '#',
       first: true,
       caption: '',
       html: { id: 'sudo-menu', method: :post },
       if: proc { User.current.sudoer? }
end

Rails.configuration.to_prepare do
  RedmineSudo.setup
end
