class CreateGlossaries < ActiveRecord::Migration[6.1]
  def change
    create_table :glossaries do |t|

      t.references :source_language, null: false,  foreign_key: { to_table: :languages }
      t.references :target_language, null: false,  foreign_key: { to_table: :languages }

      t.timestamps
    end
    add_index :glossaries, [:source_language_id, :target_language_id], unique: true
  end
end
