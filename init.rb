# frozen_string_literal: true

raise "\n\033[31maredmine_sudo requires ruby 2.6 or newer. Please update your ruby version.\033[0m" if RUBY_VERSION < '2.6'
raise 'Please activate sudo_mode in your configuration.yml, which is required for this plugin' unless Redmine::Configuration['sudo_mode']

Redmine::Plugin.register :redmine_sudo do
  name 'Redmine sudo'
  url 'https://github.com/alphanodes/redmine_sudo'
  description 'Sudo functionality for user to get admin permission'
  version RedmineSudo::VERSION
  author 'AlphaNodes GmbH'
  author_url 'https://alphanodes.com/'

  requires_redmine version_or_higher: '4.1'

  begin
    requires_redmine_plugin :additionals, version_or_higher: '3.0.1'
  rescue Redmine::PluginNotFound
    raise 'Please install additionals plugin (https://github.com/alphanodes/additionals)'
  end

  menu :account_menu, :sudo, '#',
       first: true,
       caption: '',
       html: { id: 'sudo-menu', method: :post },
       if: proc { User.current.sudoer? }
end

if Rails.version > '6.0'
  ActiveSupport.on_load(:active_record) { RedmineSudo.setup }
else
  Rails.configuration.to_prepare { RedmineSudo.setup }
end
