class Permission

  PLATFORM_ADMIN = %i{  platform_admin  }
  ANY_ADMIN      = %i{  platform_admin  store_admin }
  ANY_MANAGEMENT = %i{  platform_admin  store_admin  store_manager  }
  PUBLIC         = :PUBLIC

  def self.granted?(*args)
     new(*args).granted?
  end

  attr_reader :controller, :action, :user
  def initialize(controller, action, user)
    @controller = controller.to_sym
    @action = action.to_sym
    @user = user || User.new
  end

  def granted?
    expected_roles = permitted.try(:[], controller).try(:[], action) || []
    return true if expected_roles == PUBLIC
    actual_roles = user.roles.map(&:to_sym)

    # single `&` below takes the intersection
    !(actual_roles & expected_roles).empty?
  end

  def permitted
  # @@ because this should be the same everywhere always
    @@permitted ||= {
      carts: {
        show: PUBLIC,
        create: PUBLIC,
        update: PUBLIC,
        destroy: PUBLIC
      },
      categories: {
        show: PUBLIC
      },
      dashboards: {
        show: PUBLIC
      },
      developers: {
        show: PUBLIC,
        update: PUBLIC,
        create: PUBLIC,
      },
      chatrooms: {
        index: PUBLIC,
        show: PUBLIC,
        new: PUBLIC,
        create: PUBLIC,
        destroy: PUBLIC
      },
      messages: {
        create: PUBLIC
      },
      items: {
        show: PUBLIC,
        new: ANY_MANAGEMENT,
        edit: ANY_MANAGEMENT,
        create: ANY_MANAGEMENT,
        update: ANY_MANAGEMENT
      },
      main: {
        index: PUBLIC,
      },
      orders: {
        index: PUBLIC,
        show: PUBLIC,
      },
      sessions: {
        new: PUBLIC,
        create: PUBLIC,
        destroy: PUBLIC
      },
      stores: {
        index: PUBLIC,
        show: PUBLIC,
        new: PUBLIC,
        create: PUBLIC,
        update: ANY_ADMIN

      },
      twitter: {
        new:    ANY_ADMIN,
        create: ANY_ADMIN,
        update: ANY_ADMIN
      },
      twilio: {
        new: true,
        create: true,
        confirm: true,
        validate_key: true
      },
       charges: {
         new: PUBLIC,
         create: PUBLIC,
         thanks: PUBLIC
      },
      users: {
        new: PUBLIC,
        create: PUBLIC,
        edit: PUBLIC,
        update: PUBLIC
      },

      'admin/orders': {
        index: PLATFORM_ADMIN,
        update: PLATFORM_ADMIN
      },
      'admin/stores': {
        index: PLATFORM_ADMIN,
        update: PLATFORM_ADMIN
      },
      'admin/analytics': {
        index: PLATFORM_ADMIN
      }
    }
  end

end
