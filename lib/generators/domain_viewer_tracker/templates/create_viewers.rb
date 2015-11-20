class CreateViewers < ActiveRecord::Migration
  def change
    create_table :viewers do |t|
      t.string :uuid, null: false
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :viewers, [:user_id, :uuid], unique: true
    add_index :viewers, :uuid
  end
end
