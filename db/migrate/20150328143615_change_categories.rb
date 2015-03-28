class ChangeCategories < ActiveRecord::Migration
  def change
    change_table :categories do |t|
      t.change :enabled, :boolean, :null => false, :default => true
    end
  end
end
