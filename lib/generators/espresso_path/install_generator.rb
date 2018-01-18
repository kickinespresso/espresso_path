module EspressoPath
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      desc "Creates EspressoPath initializer for your application"

      def copy_initializer
        template "initializer.rb", "config/initializers/espresso_path.rb"

        puts "Install complete! Truly Outrageous!"
      end
    end
  end
end