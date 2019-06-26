class CreateUserhistories < ActiveRecord::Migration[5.2]
  def change
    create_table :userhistories do |t|
      t.string :name

      t.timestamps
    end
  end
end
