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

  acts_as_list
end
