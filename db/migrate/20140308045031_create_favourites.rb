class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.references :user, index: true
      t.references :movie, index: true

      t.timestamps
    end
  end
end
