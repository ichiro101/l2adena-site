require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  # non-db attributes
  attr_accessor :password

  # AR relationships
  has_many :roles

  # Data validation
  validates_uniqueness_of :username
  
  # Callbacks
  before_save :encrypt_password

  def self.authenticate(username, password)
    users = User.where(:username => username)
    if users.size == 0
      return nil
    end

    user = users.first

    encrypted = Password.new(user.hashed_password)

    if encrypted == password
      return user
    else
      return nil
    end
  end

  private

  def encrypt_password
    unless password.blank?
      encrypted = Password.create(self.password, :cost => 12)
      self.hashed_password = encrypted
    end
  end

end
