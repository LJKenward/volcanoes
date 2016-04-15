require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'volcanoes'
}

ActiveRecord::Base.establish_connection(options)