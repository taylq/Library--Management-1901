class AddDeviseToUsers < ActiveRecord::Migration[5.2]
  def self.up
    change_table :users do |t|
      t.string :encrypted_password, null: false, default: ""
      t.datetime :remember_created_at
    end

    add_index :users, :email,                unique: true
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
