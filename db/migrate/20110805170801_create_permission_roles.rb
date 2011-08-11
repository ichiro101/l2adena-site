class CreatePermissionRoles < ActiveRecord::Migration
  def self.up
    create_table :permission_roles do |t|
      t.integer :permission_id, :null => false
      t.integer :role_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :permission_roles
  end
end
