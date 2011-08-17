class CreateForums < ActiveRecord::Migration
  def self.up
    create_table :forums do |t|
      t.references :forum_category

      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :forums
  end
end
