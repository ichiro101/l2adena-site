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

  def self.find_by_symbol(symbol)
    roles = Role.all

    roles.each do |role|
      if role.symbol == symbol
        return role
      end
    end

    nil
  end


  attr_accessor :id
  attr_accessor :symbol
  attr_accessor :name
  attr_accessor :has_all_permissions

end
