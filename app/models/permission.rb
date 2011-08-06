class Permission

  def self.all
    permission_list = Array.new

    p1 = Permission.new
    p1.id = 1
    p1.symbol = :admin_panel
    p1.name = "Administrator Panel"

    permission_list << p1
  end

  def self.find_by_symbol(symbol)
    permissions = Permission.all

    permissions.each do |permission|
      if permission.symbol == symbol
        return permission
      end
    end

    nil
  end

  attr_accessor :id
  attr_accessor :symbol
  attr_accessor :name
end
