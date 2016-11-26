class AddCompletedSeasonsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :completed_seasons, :text, array: true, default: [], null: false
  end
end
