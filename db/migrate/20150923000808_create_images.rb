class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :link
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
