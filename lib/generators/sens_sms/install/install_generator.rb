module SensSms
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)
    def create_initializer
      template 'initializer.rb', 'config/initializers/sens_sms.rb'
    end
  end
end
