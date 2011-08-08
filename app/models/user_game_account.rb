class UserGameAccount < ActiveRecord::Base
  belongs_to :game_account, :primary_key => 'login'
  belongs_to :user
end
