class CreateFictions < ActiveRecord::Migration
  def change
    create_table :fictions do |t|
      t.string :path
      t.string :title
      t.string :alternate
      t.string :author
      t.boolean :state
      t.string :source
      t.string :editor
      t.string :translator
      t.string :language
      t.text :overview

      t.timestamps null: false
    end
  end
end
