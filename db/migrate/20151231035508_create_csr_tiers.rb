class CreateCsrTiers < ActiveRecord::Migration
  def change
    create_table :csr_tiers do |t|
      t.string :identifier, null: false
      t.string :name
      t.text :image_url
      t.timestamps null: false
      t.index :identifier, unique: true
    end
  end
end
