class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.string :uid, null: false
      t.string :name, null: false
      t.datetime :start_time
      t.datetime :end_time
      t.timestamps null: false
      t.index :uid, unique: true
    end
  end
end
