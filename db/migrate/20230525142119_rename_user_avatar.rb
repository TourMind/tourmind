class RenameUserAvatar < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :avatar_url, :omniauth_avatar
  end
end
