class CreateDefaultAmenities < ActiveRecord::Migration
  def up
    Amenity.create(name: "Playground")
    Amenity.create(name: "Changing Table")
    Amenity.create(name: "Nursing Area")
    Amenity.create(name: "Store")
    Amenity.create(name: "Baby Classes")
  end

  def down
    Amenity.delete_all
  end
end
