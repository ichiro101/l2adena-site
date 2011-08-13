class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.references :user
      t.string :nickname
      t.string :website

      t.text :profile_text

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
