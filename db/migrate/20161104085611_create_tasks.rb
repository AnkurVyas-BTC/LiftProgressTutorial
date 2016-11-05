class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :description
      t.integer :status
      t.integer :user_id

      t.timestamps
    end
  end
end
