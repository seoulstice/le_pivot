class Permission

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
    allowed = permitted.dig(controller, action) || []
    allowed.equal?(true) || user_has_role_in?(allowed)
  rescue Exception
    return false
  end

  def user_has_role_in?(allowed)
    roles = user.roles.map(&:to_sym)
    # single `&` below takes the intersection
    !(roles & allowed).empty?
  end

  def permitted
  # @@ because this should be the same everywhere always
    @@permitted ||= {
      "CartsController": {
        show: true,
        create: true,
        update: true,
        destroy: true
      },
      "CategoriesController": {
        show: true
      },
      "DashboardsController": {
        show: true
      },
      "DevelopersController": {
        show: true,
        update: true,
        create: true,
      },
      "ItemsController": {
        index: true,
        show: true
      },
      "MainController": {
        index: true,
      },
      "OrdersController": {
        index: true,
        show: true,
        update: true,
        create: true
      },
      "SessionsController": {
        new: true,
        create: true,
        destroy: true
      },
      stores: {
        new: true,
        create: true,
        index: true,
        update: true
        show: true

      },
      twitter: {
        new:    %i{ store_admin platform_admin },
        create: %i{ store_admin platform_admin },
        update: %i{ store_admin platform_admin }
      },
      "UsersController": {
        new: true,
        create: true,
        edit: true,
        update: true
      },

      'admin/dashboards': {
        show: [:platform_admin]
      },
      'admin/analytics': {
        show: [:platform_admin]
      },
      'admin/items': {
        index: [:platform_admin],
        new: [:platform_admin],
        create: [:platform_admin],
        update: [:platform_admin],
        edit: [:platform_admin]
      }
    }
  end

end
