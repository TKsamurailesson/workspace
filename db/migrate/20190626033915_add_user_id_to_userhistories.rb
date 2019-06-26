class AddUserIdToUserhistories < ActiveRecord::Migration[5.2]
  def change
    add_column :userhistories, :user_id, :integer
  end
end
