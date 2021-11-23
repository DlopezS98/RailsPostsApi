class HttpResponse
    attr_accessor :message, :status_code, :success, :data

    def success(message, data = nil, code = 200)
        self.message = message
        self.success = true
        self.status_code = code
        self.data = data
        return self
    end

    # error on process de request with default code 400 bad request
    def error(message, code = 400, data = nil)
        self.message = message
        self.success = false
        self.status_code = code
        self.data = data
        return self
    end
end