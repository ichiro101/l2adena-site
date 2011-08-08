class GameAccount < ActiveRecord::Base
  has_many :user_game_accounts, :foreign_key => 'login'

  establish_connection(
    :adapter => 'mysql2',
    :host => Rails.configuration.login_server_database_host,
    :port => Rails.configuration.login_server_database_port,
    :username => Rails.configuration.login_server_database_username,
    :password => Rails.configuration.login_server_database_password,
    :database => Rails.configuration.login_server_database_name
  )

  set_table_name 'accounts'
end
