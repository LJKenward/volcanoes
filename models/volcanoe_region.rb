class VolcanoeRegion < ActiveRecord::Base
  has_many :volcanoes # teaching VolcanoeType that there are many volcanoes. 
end
