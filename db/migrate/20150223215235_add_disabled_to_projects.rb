class AddDisabledToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :disabled, :boolean
  end
end
