class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.integer :category_id
      t.integer :publisher_id
      t.string :name
      t.text :content
      t.integer :number_of_page
      t.integer :status
      t.string :image

      t.timestamps
    end
  end
end
