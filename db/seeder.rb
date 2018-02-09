class Seeder

  def self.add_roles
    Role.create(name: "registered_user")
    Role.create(name: "store_manager")
    Role.create(name: "store_admin")
    Role.create(name: "platform_admin")
  end

end
