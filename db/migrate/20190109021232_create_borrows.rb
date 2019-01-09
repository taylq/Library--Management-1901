class CreateBorrows < ActiveRecord::Migration[5.2]
  def change
    create_table :borrows do |t|
      t.integer :book_id
      t.integer :user_id
      t.datetime :started_at
      t.datetime :finished_at
      t.integer :status

      t.timestamps
    end
  end
end
