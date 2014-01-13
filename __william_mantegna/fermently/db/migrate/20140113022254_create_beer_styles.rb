class CreateBeerStyles < ActiveRecord::Migration
  def change
    create_table :beer_styles do |t|
      t.string :name
      t.string :category
      t.string :description
      t.float :abvMin
      t.float :abvMax
      t.float :ibuMin
      t.float :ibuMax
      t.float :ogMin
      t.float :ogMax
      t.float :fgMin
      t.float :fgMax
      t.float :srmMin
      t.float :srmMax

      t.timestamps
    end
  end
end
