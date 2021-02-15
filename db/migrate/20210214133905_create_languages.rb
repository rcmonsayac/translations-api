class CreateLanguages < ActiveRecord::Migration[6.1]
  def change
    create_table :languages do |t|

      t.string :code, null: false
      t.string :country, null: false
      t.timestamps
    end
  end
end
