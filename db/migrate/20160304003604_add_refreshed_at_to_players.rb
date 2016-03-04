class AddRefreshedAtToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :refreshed_at, :datetime
  end
end
