class V1::AuthController < ApplicationController
    def index
        user = User.all
        render json: user, status: :ok
    end

    def sign_in
        user = User.where(email: params[:email]).first
        auth = user.valid_password?(params[:password])

        if auth
            render json: { message: "You're logged in successfully!" }, status: :ok
        else
            render json: { message: 'The password is wrong!' }, status: :bad_request
        end
    end

    def sign_up
        user_params = params.require(:user).permit(:email, :username, :firstname, :lastname, :password)
        user = User.new(user_params)
        user.commit_user
        render json: { message: 'sign up success!' }, status: :ok
    end
end
