class CreateTerms < ActiveRecord::Migration[6.1]
  def change
    create_table :terms do |t|

      t.string :source,  null: false
      t.string :target,  null: false
      t.references :glossary, null: false,  foreign_key: { to_table: :glossaries }
      t.timestamps
    end
  end
end
