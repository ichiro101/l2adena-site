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

  # Assign the role of :symbol to the user
  def assign_role(symbol)
    role = Role.find_by_symbol(symbol)

    if role == nil
      return nil
    end

    user_roles = UserRole.where(:user_id => self.id, :role_id => role.id)
    if user_roles.size > 0
      return true
    end

    user_role = UserRole.new
    user_role.user_id = self.id
    user_role.role_id = role.id
    user_role.save
  end

  # Check if the user has the role of :symbol
  def has_role?(symbol)
    role = Role.find_by_symbol(symbol)
    user_roles = UserRole.where(:user_id => self.id, :role_id => role.id)

    if user_roles.size > 0
      return true
    else
      return false
    end
  end

  def can_access?(symbol)
    user_roles = UserRole.where(:user_id => self.id)

    user_roles.each do |user_role|
      role = Role.find(user_role.role_id)
      if role.has_all_permissions == true
        return true
      elsif role.has_permission?(symbol)
        return true
      end
    end

    false
  end

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
