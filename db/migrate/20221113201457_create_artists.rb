class CreateArtists < ActiveRecord::Migration[6.1]
  def change
    create_table :artists do |t|
      t.text :name, null: false
      t.timestamps
    end
  end
end
