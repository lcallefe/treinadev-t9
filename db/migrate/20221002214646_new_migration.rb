class NewMigration < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :admin, :boolean
  end
end
