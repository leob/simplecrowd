class ChangeNameLimitForProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.change :name, :string, limit: 80
    end
  end
  def self.down
    change_table :tablename do |t|
      t.change :name, :string, limit: 255
    end
  end
end
