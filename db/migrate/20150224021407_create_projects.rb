class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :summary
      t.text :description
      t.references :user, index: true
      t.money :target_amount
      t.money :collected_amount
      t.boolean :draft
      t.boolean :disabled
      t.boolean :editor_pick

      t.timestamps null: false
    end
    add_foreign_key :projects, :users
  end
end
