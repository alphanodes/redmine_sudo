# frozen_string_literal: true

Deface::Override.new virtual_path: 'users/_form',
                     name: 'users-replace-admin-with-sudo',
                     replace: 'erb[loud]:contains("f.check_box :admin")',
                     original: 'e60a4fa50dfadff1543026068000af0103515325',
                     partial: 'users/sudo_checkbox'
