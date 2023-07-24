class ApplicationController < ActionController::Base
    
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    
    def not_found
        render file: Rails.root.join("public", "404.html"),
               status: 404,
               layout: false
    end


    helper_method :user_signed_in?, :current_user

    private

    def user_signed_in?
        session[:member].present?
    end

    def current_user
        if user_signed_in?
            #記憶的方法
            @__user__ = @__user__ || User.find_by(id: session[:member])
        else
            nil
        end
    end
    
    def authenticate_user!
        if not user_signed_in?
          redirect_to login_users_path, notice: '請先登入會員'
        end
      end
end
