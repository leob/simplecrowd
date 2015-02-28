class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :summary
      t.text :description
      t.integer :user_id
      t.money :target_amount
      t.money :collected_amount
      t.boolean :draft, default: true
      t.boolean :disabled, default: false
      t.boolean :editor_pick, default: false

      t.timestamps null: false
    end
    add_index :projects, :user_id
  end
end
