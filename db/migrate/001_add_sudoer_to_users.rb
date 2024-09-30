# frozen_string_literal: true

class AddSudoerToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :sudoer, :boolean, default: false, null: false
    User.where(admin: true).update_all sudoer: true
    User.update_all admin: false
  end

  def down
    User.where(sudoer: true).update_all admin: true
    remove_column :users, :sudoer
  end
end
