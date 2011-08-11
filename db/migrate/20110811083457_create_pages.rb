class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :permalink
      t.string :name
      t.text :content
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
