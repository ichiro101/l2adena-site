class Role

  def self.all
    role_list = Array.new

    r1 = Role.new
    r1.id = 1
    r1.symbol = :owner
    r1.name = "Owner"
    r1.has_all_permissions = true
    role_list << r1

    r2 = Role.new
    r2.id = 2
    r2.symbol = :admin
    r2.name = "Administrator"
    r2.has_all_permissions = false
    role_list << r2

    r3 = Role.new
    r3.id = 3
    r3.symbol = :gamemaster
    r3.name = "Gamemaster"
    r3.has_all_permissions = false
    role_list << r3

    role_list
  end

  def self.find(id)
    roles = Role.all

    roles.each do |role|
      if role.id == id
        return role
      end
    end

    nil
  end

  def self.find_by_symbol(symbol)
    roles = Role.all

    roles.each do |role|
      if role.symbol == symbol
        return role
      end
    end

    nil
  end

  def assign_permission(symbol)
    permission = Permission.find_by_symbol(symbol)

    if permission == nil
      return nil
    end

    permission_roles = PermissionRole.where(:permission_id => permission.id, :role_id => self.id)

    if permission_roles.size == 0
      permission_role = PermissionRole.new
      permission_role.permission_id = permission.id
      permission_role.role_id = self.id
      return permission_role.save
    end

    true
  end

  def has_permission?(symbol)
    permission = Permission.find_by_symbol(symbol)

    if permission == nil
      raise StandardError, "Permission does not exist"
    end

    permission_roles = PermissionRole.where(:permission_id => permission.id, :role_id => self.id)

    if permission_roles.size > 0
      return true
    else
      return false
    end
  end

  attr_accessor :id
  attr_accessor :symbol
  attr_accessor :name
  attr_accessor :has_all_permissions

end
