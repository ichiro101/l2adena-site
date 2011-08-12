require 'bcrypt'
class GameAccount < ActiveRecord::Base
  include BCrypt

  set_primary_key :login

  has_many :user_game_accounts, :primary_key => 'login', :foreign_key => 'login'

  establish_connection(
    :adapter => 'mysql2',
    :host => Rails.configuration.login_server_database_host,
    :port => Rails.configuration.login_server_database_port,
    :username => Rails.configuration.login_server_database_username,
    :password => Rails.configuration.login_server_database_password,
    :database => Rails.configuration.login_server_database_name
  )

  # Assuming we still follow l2j table name conventions
  set_table_name 'accounts'

  validates_uniqueness_of :login
  validates_presence_of :login
  validates_presence_of :plain_password, :on => :create

  # convert plain_password to password
  before_save :encrypt_password
  before_save :set_default_server
  attr_accessor :plain_password

  private

  def encrypt_password
    unless self.plain_password.blank?
      if Rails.configuration.use_bcrypt
        encrypted = Password.create(self.plain_password, :cost => 12)
        self.password = "bcrypt:#{encrypted}"
      else
        self.password = GameAccount.old_encrypt(self.plain_password)
      end
    end
  end

  def set_default_server
    self.lastServer = 13
  end

  # Use the default l2j encryption
  #
  # NOTE: This is not as secure as BCrypt. Please see
  # http://codahale.com/how-to-safely-store-a-password/
  def self.old_encrypt(password)
    sha1_hash = Digest::SHA1.hexdigest password
    crypt = Base64.encode64(sha1_hash.split.pack("H*"))
  end

end
