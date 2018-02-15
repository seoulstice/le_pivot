class Seeder

  def self.create_roles
    Role.create(name: "registered_user")
    Role.create(name: "store_manager")
    Role.create(name: "store_admin")
    Role.create(name: "platform_admin")
  end

  def self.create_original_store
    Store.create(name: "The Little Shop of Funsies", status: "active")
  end

end
