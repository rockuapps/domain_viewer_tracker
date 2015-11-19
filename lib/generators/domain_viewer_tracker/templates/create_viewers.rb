class CreateViewers < ActiveRecord::Migration
  def change
    create_table :viewers do |t|
      t.string :uuid
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :viewers, [:uuid, :user_id], unique: true
  end
end
