class Seeder
  include FactoryBot::Syntax::Methods

  CATEGORIES = 5
  ITEMS_PER_CATEGORY = 5
  GENERIC_STORES = 5
  GENERIC_USERS = 4
  ORDERS_PER_USER = 1..5
  ORDER_ITEMS_PER_ORDER = 1..5

  def create_all
    ActiveRecord::Base.transaction do
      @stores = create_stores
      @stores.push create_turing
      create_categories
      create_users
    end
  end

  def create_roles
    Role.create(name: "registered_user")
    Role.create(name: "store_manager")
    Role.create(name: "store_admin")
    Role.create(name: "platform_admin")
  end

  def create_stores
    create_list(:store, GENERIC_STORES) do |store|
      create_business_manager(store)
      create_business_admin(store)
    end
  end

  def create_categories
    create_list(:category, CATEGORIES) { |category| create_items(category)  }
  end

  def create_items(category)
    create_list(:item, ITEMS_PER_CATEGORY,
      category: category,
      store: @stores.sample
    )
  end

  def create_users
    create_list(:user, GENERIC_USERS) { |user| create_orders(user) }
  end

  def create_business_manager(store)
    create(:store_manager, store: store )
  end

  def create_business_admin(store)
    create(:store_admin, store: store)
  end

  def create_orders(user)
    create_list(:order, rand(ORDERS_PER_USER), user: user) { |order| create_order_items(order) }
  end

  def create_order_items(order)
    create_list(:order_item, rand(ORDER_ITEMS_PER_ORDER),
      order: order,
      item: random_record(Item)
    )
  end

  def create_turing
    create_ian
    store = create(:store)
    create_josh(store)
    create_cory(store)
    store
  end

  def create_josh(store)
    create(:store_manager,
      username: 'josh@turing.io',
      email: 'josh@turing.io',
      store: store
    ){ |user| create_orders(user) }
  end

  def create_cory(store)
    create(:store_admin,
      username: 'cory@turing.io',
      email: 'cory@turing.io',
      store: store
    )
  end

  def create_ian
    create(:platform_admin,
      username: 'ian@turing.io',
      email: 'ian@turing.io'
    )
  end

  def random_record(model)
    model.order('RANDOM()').first
  end

  def self.create_original_store
    Store.create(name: "The Little Shop of Funsies", status: "active")
  end

end
