class Place < ActiveRecord::Base
  has_and_belongs_to_many :amenities
  validates :name, :latitude, :longitude, :address, presence: true
end
