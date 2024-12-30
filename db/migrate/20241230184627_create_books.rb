class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.datetime :publication_date, null: false
      t.integer :rating, null: true, default: 0
      t.string :status, null: true, default: 'available'

      t.timestamps
    end
  end
end
