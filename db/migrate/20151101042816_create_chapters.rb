class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.integer :chapnum
      t.text :title
      t.text :body
      t.references :fiction, index: true

      t.timestamps null: false
    end
    add_foreign_key :chapters, :fictions
  end
end
