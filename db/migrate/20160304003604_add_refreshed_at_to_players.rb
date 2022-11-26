class AddRefreshedAtToPlayers < ActiveRecord::Migration[4.2]
  def change
    add_column :players, :refreshed_at, :datetime
  end
end
