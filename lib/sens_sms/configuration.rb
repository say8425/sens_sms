module SensSms
  module Configuration
    def access_key
      self.class.class_variable_get(:@@access_key)
    end

    def secret_key
      self.class.class_variable_get(:@@secret_key)
    end

    def service_id
      self.class.class_variable_get(:@@service_id)
    end
  end
end
