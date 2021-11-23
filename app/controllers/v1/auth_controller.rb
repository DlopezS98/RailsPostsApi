class V1::AuthController < ApplicationController
    skip_before_action :process_token, only: [:sign_in, :sign_up]

    def index
        user = User.all
        render json: user, status: :ok
    end

    def sign_in
        user = User.where(email: params[:email]).first
        auth = user.valid_password?(params[:password])
        token = Security::JsonWebToken.encode(get_token_payload(user))

        if auth
            render json: HttpResponse.new.success("You're logged in successfully!", { token: token }) , status: :ok
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
