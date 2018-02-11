class StoreCreator

  def self.create_store(user, name)
    role = Role.find_by!(name: "store_admin")
    store = Store.create!(name: name, slug: name.parameterize)
    UserRole.create!(user: user, store: store, role: role)
    store
  end

end
