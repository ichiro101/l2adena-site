class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.references :user
      t.references :forum

      t.string :name
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end
