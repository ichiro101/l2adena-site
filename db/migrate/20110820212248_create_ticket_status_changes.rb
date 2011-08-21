class CreateTicketStatusChanges < ActiveRecord::Migration
  def self.up
    create_table :ticket_status_changes do |t|
      t.references :user, :null => false
      t.references :ticket, :null => false

      t.integer :status_change, :null => false

      t.timestamps
    end

    add_index :ticket_status_changes, :user_id
    add_index :ticket_status_changes, :ticket_id
  end

  def self.down
    remove_index :ticket_status_changes, :column => :ticket_id
    remove_index :ticket_status_changes, :column => :user_id

    drop_table :ticket_status_changes
  end
end
