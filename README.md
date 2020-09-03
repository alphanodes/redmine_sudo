Sudo plugin for Redmine
==================================

[![Rate at redmine.org](https://img.shields.io/badge/rate%20at-redmine.org-blue.svg?style=flat)](https://www.redmine.org/plugins/redmine_sudo) ![Run Linters](https://github.com/AlphaNodes/redmine_sudo/workflows/Run%20Linters/badge.svg) ![Run Linters](https://github.com/AlphaNodes/redmine_sudo/workflows/Run%20Brakeman/badge.svg) ![Run Tests](https://github.com/AlphaNodes/redmine_sudo/workflows/Test/badge.svg)

Features
--------

* User can switch to admin permission
* User with admin permission can drop admin permission

PROs vs default behavior
------------------------

* no extra user with admin permissions is required. Common use case is, to create a user called "admin" for it and multible other users use it.
* fast switch between admin permisson and default user permission
* Automatically timeout of working time with admin permission (can be configured with sudo_mode_timeout).

Break Redmine default
---------------------

If a user has the to have admin permisson, he has not this permission after login. He/she has to switch to it (with top menu toggle) to get it. Redmine sudo-mode is used for time period and requesting password to switch to admin permission.


Redmine Requirements
--------------------

* Redmine version >= 4.1
* Redmine Plugin: [additionals](https://github.com/alphanodes/additionals)
* Ruby version >= 2.4.0
* Redmine sudo_mode has to be turned on in config/configuration.yml


Installation
------------

Note: all existing admin users will be converted to sudoer (which means, they can switch to admin)

Install ``redmine_sudo`` plugin for `Redmine`

    cd $REDMINE_ROOT
    git clone git://github.com/alphanodes/redmine_sudo.git plugins/redmine_sudo
    git clone git://github.com/alphanodes/additionals.git plugins/additionals
    bundle install --without development test
    bundle exec rake redmine:plugins:migrate RAILS_ENV=production

Restart Redmine (application server) and you should see the plugin show up in the Plugins page.


Uninstall
---------

Note: all existing sudoer users will be converted to admin users.

Uninstall ``redmine_sudo``

    cd $REDMINE_ROOT
    bundle exec rake redmine:plugins:migrate NAME=redmine_sudo RAILS_ENV=production
    rm -rf plugins/redmine_sudo

Restart Redmine (application server)


Known problems
--------------

* for api calls admin permissions are temorarily set for sudoer (not to database). This can be some negative side effect for some return values
