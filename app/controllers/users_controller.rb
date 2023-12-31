class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to root_path, notice:"會員新增成功囉 ! "
        else
            render :new
        end
    end

    def login
    end
    
    def logining
        user = User.login(params[:user][:email], params[:user][:password])
        
        session[:member] = user.id

        if user
            redirect_to root_path, notice: '登入成功'
        else
            redirect_to login_users_path, alert: '登入失敗'
        end
    end
    
    def logout
        session[:member] = nil
        redirect_to root_path, notice:"登出成功囉 ! "
    end
    

    def user_params
        params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    end
    
end
