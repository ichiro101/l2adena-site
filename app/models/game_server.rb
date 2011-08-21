class GameServer < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :gameserver_hostname
  validates_presence_of :gameserver_port
  validates_presence_of :gameserver_database_hostname
  validates_presence_of :gameserver_database_port
  validates_presence_of :gameserver_database_username
  validates_presence_of :gameserver_database_password
  validates_presence_of :gameserver_database_name

  validate :database_connectable
  validate :is_l2j_gameserver_database

  acts_as_list

  private

  def database_connectable
    begin
      client = Mysql2::Client.new(:host => self.gameserver_database_hostname,
                                  :port => self.gameserver_database_port,
                                  :username => self.gameserver_database_username,
                                  :password => self.gameserver_database_password,
                                  :database => self.gameserver_database_name)
    rescue Exception => e
      errors.add(:base, "Please check your connection info, error was #{e.message}")
    end
  end

  # do a sanity check to see if the database has tables that I expect to have
  # in a l2j gameserver database
  def is_l2j_gameserver_database
    begin
      client = Mysql2::Client.new(:host => self.gameserver_database_hostname,
                                  :port => self.gameserver_database_port,
                                  :username => self.gameserver_database_username,
                                  :password => self.gameserver_database_password,
                                  :database => self.gameserver_database_name)
      begin
        client.query("DESCRIBE characters")
        client.query("DESCRIBE char_templates")
      rescue Exception => e2
        errors.add(:base, "This does not look like a valid l2j gameserver database")
      end
    rescue Exception => e
      # ignore everything since we check for database connectivity in another
      # method
    end
  end

end
