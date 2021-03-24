# frozen_string_literal: true

Deface::Override.new virtual_path: 'users/index',
                     name: 'users-list-replace-admin-header',
                     replace: 'erb[loud]:contains("sort_header_tag(\'admin\'")',
                     original: 'dc128c3cc172a8abe16a92d97e8fd20a2aa40427',
                     partial: 'users/sudo_list_header'
Deface::Override.new virtual_path: 'users/index',
                     name: 'users-list-replace-admin-column',
                     replace_contents: 'td.tick',
                     original: 'edc31bce1cac515de516f73c53f92a61c942301f',
                     partial: 'users/sudo_list_column'
