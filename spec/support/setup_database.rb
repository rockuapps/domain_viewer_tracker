ActiveRecord::Base.configurations = {'test' => {adapter: 'sqlite3', database: ':memory:'}}
ActiveRecord::Base.establish_connection :test

class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table :viewers do |t|
      t.string :uuid
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :viewers, [:uuid, :user_id], unique: true
  end
end

ActiveRecord::Migration.verbose = false
CreateAllTables.up
