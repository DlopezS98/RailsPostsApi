class HttpStandardError < StandardError
    attr_reader :message, :code, :status_code
    def initialize(message: nil, status_code: :bad_request)
        @message = message || 'Ups! Something went wrong!'
        @status_code = status_code
        @code = Rack::Utils::SYMBOL_TO_STATUS_CODE[status_code]
    end
end