class GameAccount < ActiveRecord::Base
  set_primary_key :login

  has_many :user_game_accounts, :foreign_key => 'login'

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
end
