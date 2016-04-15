require'pry'
require 'active_record'

ActiveRecord::Base.logger = Logger.new(STDERR)

require './db_config'
require './models/volcanoe'
require './models/volcanoe_region'
require './models/comment'
require './models/user'

binding.pry