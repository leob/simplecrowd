class AddColumnsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :start_date, :datetime
    add_column :projects, :end_date, :datetime
    add_column :projects, :extended, :integer,default: 0, null: false
    add_column :projects, :old_end_date, :datetime
  end
end
