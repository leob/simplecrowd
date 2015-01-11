class AddEditorPickToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :editor_pick, :boolean
  end
end
