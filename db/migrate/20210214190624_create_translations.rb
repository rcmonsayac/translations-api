class CreateTranslations < ActiveRecord::Migration[6.1]
  def change
    create_table :translations do |t|

      t.references :source_language, null: false,  foreign_key: { to_table: :languages }
      t.references :target_language, null: false,  foreign_key: { to_table: :languages }
      t.text :source_text, null: false, limit: 5000
      t.references :glossary, null: true,  foreign_key: { to_table: :glossaries }
      t.timestamps
    end
  end
end
