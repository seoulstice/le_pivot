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
      redirect_to login_path unless current_user
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
<<<<<<< HEAD
      @user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def all_categories
      @categories ||= Category.all
=======
      @user = User.find_by_id(session[:user_id]) || User.guest
    end

    def all_categories
      @all_categories = Category.all
>>>>>>> revert permissions
    end

    def cart
      @cart ||= Cart.new(session[:cart])
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
      if current_user.roles.empty?
        dashboard_path
      else
        admin_dashboard_path
      end
    end

end
