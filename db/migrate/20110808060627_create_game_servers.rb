class CreateGameServers < ActiveRecord::Migration
  def self.up
    create_table :game_servers do |t|
      # The database name
      t.string :name

      # Used for checking server status
      t.string :gameserver_hostname
      t.string :gameserver_port

      # Used to connect to a game server
      t.string :gameserver_database_hostname
      t.string :gameserver_database_port
      t.string :gameserver_database_username
      t.string :gameserver_database_password
      t.string :gameserver_database_name

      t.timestamps
    end
  end

  def self.down
    drop_table :game_servers
  end
end
