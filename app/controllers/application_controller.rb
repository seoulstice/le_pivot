class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize!
  after_action :save_cart

  helper_method :current_user,
                :cart,
                :all_categories

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

    def flash_success(message)
      flash[:success] = message
    end

    def flash_error(message)
      flash[:error] = message
    end

    def flash_validation_errors(record)
      flash_error(record.errors.full_messages.join("\n"))
    end

    def try_save(record, happy_path, sad_path = nil, message)
      if record.save
        flash_success(message)
        redirect_to(happy_path)
        true
      else
        flash_validation_errors(record)
        if sad_path
          redirect_back(fallback_location: sad_path)
        else
          render record.new_record? ? :new : :edit
        end
        false
      end
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end

end
