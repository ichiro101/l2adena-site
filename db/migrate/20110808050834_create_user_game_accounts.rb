class CreateUserGameAccounts < ActiveRecord::Migration
  def self.up
    create_table :user_game_accounts do |t|
      t.references :user
      t.string :login

      t.timestamps
    end
  end

  def self.down
    drop_table :user_game_accounts
  end
end
