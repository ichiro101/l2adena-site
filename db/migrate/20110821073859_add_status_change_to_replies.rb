class AddStatusChangeToReplies < ActiveRecord::Migration
  def self.up
    add_column :ticket_replies, :ticket_status_change_id, :integer
    add_index :ticket_replies, :ticket_status_change_id
  end

  def self.down
    remove_index :ticket_replies, :column => :ticket_status_change_id
    remove_column :ticket_replies, :ticket_status_change_id
  end
end
