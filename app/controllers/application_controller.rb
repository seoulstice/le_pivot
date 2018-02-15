class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize!
  after_action :save_cart

  helper_method :current_user,
                :cart,
                :all_categories,
                :current_dashboard_path

  private

    def authenticate!
      redirect_to login_path unless current_user.registered?
    end

    def authorize!
      not_found unless Permission.granted?(
        params[:controller],
        params[:action],
        current_user
      )
    end

    def save_cart
      session[:cart] = cart.contents
    end

    def current_user
      @user ||= User.find_by_id(session[:user_id]) || User.guest
    end

    def cart
      @cart ||= CartDecorator.new(Cart.new(session[:cart]))
    end

    def all_categories
      @all_categories ||= Category.all
    end

    def current_dashboard_path
      if current_user.platform_admin?
        admin_dashboard_path else dashboard_path
      end
    end

    def flash_success(message)
      flash[:success] = message
    end

    def flash_error(message)
      flash[:error] = message
    end

    def flash_validation_errors(record)
      flash_error(record.errors.full_messages.join("\n"))
    end

    def try_save(record, happy_path, sad_path, message)
      if record.save
        flash_success(message)
        redirect_to(happy_path)
        true
      else
        flash_validation_errors(record)
        redirect_back(fallback_location: sad_path)
        false
      end
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end

end
