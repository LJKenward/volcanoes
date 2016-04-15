class Volcanoe < ActiveRecord::Base
  belongs_to :volcanoe_region

  has_many :comments
end