class AddStatusToAvatar < ActiveRecord::Migration
  def change
    add_column :avatars, :status, :string, default: "active"
  end
end
