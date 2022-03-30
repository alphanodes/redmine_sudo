# frozen_string_literal: true

raise 'Please activate sudo_mode in your configuration.yml, which is required for this plugin' unless Redmine::Configuration['sudo_mode']

loader = RedminePluginKit::Loader.new plugin_id: 'redmine_sudo'

Redmine::Plugin.register :redmine_sudo do
  name 'Redmine sudo'
  url 'https://github.com/alphanodes/redmine_sudo'
  description 'Sudo functionality for user to get admin permission'
  version RedmineSudo::VERSION
  author 'AlphaNodes GmbH'
  author_url 'https://alphanodes.com/'

  requires_redmine version_or_higher: '5.0'

  begin
    requires_redmine_plugin :additionals, version_or_higher: '3.0.6'
  rescue Redmine::PluginNotFound
    raise 'Please install additionals plugin (https://github.com/alphanodes/additionals)'
  end

  menu :account_menu, :sudo, '#',
       first: true,
       caption: '',
       html: { id: 'sudo-menu', method: :post },
       if: proc { User.current.sudoer? }
end

RedminePluginKit::Loader.persisting { loader.load_model_hooks! }
