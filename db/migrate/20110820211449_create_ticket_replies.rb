class CreateTicketReplies < ActiveRecord::Migration
  def self.up
    create_table :ticket_replies do |t|
      t.references :user, :null => false
      t.references :ticket, :null => false

      t.text :content

      t.timestamps
    end

    add_index :ticket_replies, :user_id
    add_index :ticket_replies, :ticket_id
  end

  def self.down
    remove_index :ticket_replies, :column => :ticket_id
    remove_index :ticket_replies, :column => :user_id

    drop_table :ticket_replies
  end
end
