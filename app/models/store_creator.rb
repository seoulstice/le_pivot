class StoreCreator

  def self.create_store(user, store_params)
    role = Role.find_by(name: "store_admin")
    store = Store.create(store_params, slug: store_params[:name].parameterize)
    UserRole.create(user: user, store: store, role: role )
    store
  end

end
