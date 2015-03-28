class AddCategoryToProject < ActiveRecord::Migration
  def change
    add_reference :projects, :category, index: true
    add_foreign_key :projects, :categories
  end
end
