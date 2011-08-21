class Permission

  def self.all
    permission_list = Array.new

    p1 = Permission.new
    p1.id = 1
    p1.symbol = :admin_panel
    p1.name = "Administrator Panel"
    permission_list << p1

    p2 = Permission.new
    p2.id = 2
    p2.symbol = :gameserver_information
    p2.name = "Database Information"
    permission_list << p2

    permission_list
  end

  def self.find_by_symbol(symbol)
    permissions = Permission.all

    permissions.each do |permission|
      return permission if permission.symbol == symbol
    end

    nil
  end

  attr_accessor :id
  attr_accessor :symbol
  attr_accessor :name
end
