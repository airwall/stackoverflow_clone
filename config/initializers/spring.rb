# config/spring.rb
require 'spring/application'

class Spring::Application
  alias connect_database_orig connect_database

  def connect_database
    disconnect_database
    reconfigure_database
    connect_database_orig
  end

  def reconfigure_database
    if active_record_configured?
      ActiveRecord::Base.configurations =
          Rails.application.config.database_configuration
    end
  end
end
