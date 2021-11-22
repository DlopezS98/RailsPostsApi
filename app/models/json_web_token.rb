class Security::JsonWebToken
    
    def self.encode(payload)
        JWT.encode({ payload: payload, exp: 60.days.from_now.to_i }, Rails.application.secrets.secret_key_base)
    end

    def self.decode(token)
        JWT.decode(token, Rails.application.secret_key_base).first
    end
end