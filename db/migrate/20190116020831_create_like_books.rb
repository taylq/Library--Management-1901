class CreateLikeBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :like_books do |t|
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
    add_index :like_books, :book_id
    add_index :like_books, :user_id
    add_index :like_books, [:book_id, :user_id], unique: true
  end
end
