class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :director
      t.date :release
      t.text :genre

      t.timestamps
    end
  end
end
