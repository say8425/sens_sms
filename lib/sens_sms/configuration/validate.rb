module SensSms
  module Configuration
    module Validate
      def validate_configure
        validate_configure_defined? && validate_configure_exist?
      end

      def validate_configure_defined?
        self.class.class_variable_defined?(:@@access_key) &&
          self.class.class_variable_defined?(:@@service_id) &&
          self.class.class_variable_defined?(:@@secret_key)
      end

      def validate_configure_exist?
        !self.class.class_variable_get(:@@access_key).nil? &&
          !self.class.class_variable_get(:@@service_id).nil? &&
          !self.class.class_variable_get(:@@secret_key).nil?
      end
    end
  end
end
