class Place < ActiveRecord::Base
  validates :name, :amenities, :latitude, :longitude, presence: true
end
