class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.references :beer_style
      t.float :og
      t.float :fg
      t.float :abv
      t.datetime :dateBrewed
      t.datetime :dateBottled
      t.string :priming
      t.string :recipe
      t.float :rating
      t.text :brewerComment

      t.timestamps
    end
  end
end
