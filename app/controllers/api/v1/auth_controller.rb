class Api::V1::AuthController < ApplicationController
    skip_before_action :process_token, only: [:sign_in, :sign_up]

    def index
        user = User.all
        render json: user, status: :ok
    end

    def sign_in
        user = User.where(email: params[:email]).first
        raise HttpStandardError.new(message: "The email is wrong or doesn't exists!") unless user
        valid_password = user.valid_password?(params[:password])

        raise HttpStandardError.new(message: "The password is wrong!") unless valid_password
        token = Security::JsonWebToken.encode(get_token_payload(user))
        render json: HttpResponse.new.success(message: "You're logged in successfully!", data: { token: token }) , status: :ok
    end

    def sign_up
        user_params = params.require(:user).permit(:email, :username, :firstname, :lastname, :password)
        user = User.new(user_params)
        user.commit_user
        render json: HttpResponse.new.success(message: "Sign up successfully!"), status: :ok
    end

    private 
    def get_token_payload(user)
        payload = { 
            id: user.id,
            email: user.email,
            username: user.username,
            created_at: user.created_at,
            roles: []
        }
        return payload
    end
end
