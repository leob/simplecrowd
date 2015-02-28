class AddSummaryToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :summary, :text
  end
end
