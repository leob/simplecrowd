class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name_nl
      t.string :name_en
      t.boolean :enabled

      t.timestamps null: false
    end
  end
end
