class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :datetime_created
      t.integer :user_id
    end
  end
end
