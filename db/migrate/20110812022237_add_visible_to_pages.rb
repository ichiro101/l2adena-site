class AddVisibleToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :visible, :boolean
  end

  def self.down
    remove_column :pages, :visible
  end
end
