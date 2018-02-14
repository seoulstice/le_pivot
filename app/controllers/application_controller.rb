class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize!

  helper_method :logged_in?,
                :current_user,
                :current_dashboard_path,
                :all_categories,
                :cart

  private

    def authenticate!
      redirect_to login_path unless logged_in?
    end

    def authorize!
      not_found unless Permission.granted?(
        params[:controller],
        params[:action],
        current_user
      )
    end

    def logged_in?
      current_user.persisted?
    end

    def current_user
      @user ||= User.find_by_id(session[:user_id]) || User.guest
    end

    def all_categories
      @all_categories = Category.all
    end

    def cart
      @cart ||= CartDecorator.new(Cart.new(session[:cart]))
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end

    def flash_success(message = 'Your changes have been saved')
      flash[:success] = message
    end

    def flash_errors(record)
      flash[:error] = record.errors.full_messages.join("\n")
    end

    # soon, we should consolidate ALL dashboards?
    def current_dashboard_path
      if current_user.platform_admin?
        admin_dashboard_path
      else
        dashboard_path
      end
    end

    # BANG because this will remove other scopes, e.g. filtering by status
    # you can still filter the return, but not the argument
    def platform_admin_sees_all!(relation)
      if current_user.platform_admin?
        relation.unscope(:where) else relation
      end
    end

end
