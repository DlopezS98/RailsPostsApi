class ApplicationController < ActionController::API
    respond_to :json
    before_action :set_defaul_format
    before_action :process_token

    private

    def process_token
        if request.headers['Authorization'].present?
            begin
                token = request.headers['Authorization'].split(' ')[1]
                jwt_payload = Security::JsonWebToken.decode(token)
                @current_user_id = jwt_payload['payload']['id']
                rescue JWT::ExpiredSignature
                    render json: HttpResponse.new.error("The auth token has expired"), status: :bad_request
                rescue JWT::VerificationError
                    render json: HttpResponse.new.error("Unexpected error on process the token", 500), status: :internal_server_error
                rescue JWT::DecodeError
                    render json: HttpResponse.new.error("The provided token is invalid"), status: :bad_request
            end
        else
            render json: HttpResponse.new.error("Unauthorized, please login!", 401), status: :unauthorized
        end
    end

    # If user has not signed in, return unauthorized response (called only when auth is needed)
    def authenticate_user!(options = {})
        head :unauthorized unless signed_in?
    end

    def current_user
        @current_user = User.find(@current_user_id)
    end

    def set_defaul_format
        request.format = :json
    end

    # check that authenticate_user has successfully returned @current_user_id (user is authenticated)
    def signed_in?
        @current_user_id.present?
    end
end
