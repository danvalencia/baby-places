class CreateAmenitiesPlaces < ActiveRecord::Migration
  def change
    create_table :amenities_places, id: false do |t|
      t.belongs_to :place, index: true
      t.belongs_to :amenity, index: true
    end
  end
end
