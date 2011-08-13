class AddPositionAndVisibilityToGameservers < ActiveRecord::Migration
  def self.up
    add_column :game_servers, :visible, :boolean
    add_column :game_servers, :position, :integer
  end

  def self.down
    remove_column :game_servers, :position
    remove_column :game_servers, :visible
  end
end
