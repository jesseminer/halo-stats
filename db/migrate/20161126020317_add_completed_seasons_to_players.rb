class AddCompletedSeasonsToPlayers < ActiveRecord::Migration[4.2]
  def change
    add_column :players, :completed_seasons, :text, array: true, default: [], null: false
  end
end
