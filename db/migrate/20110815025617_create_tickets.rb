class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.references :user
      t.string :name
      t.text :content
      t.integer :status

      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
