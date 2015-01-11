class Project < ActiveRecord::Base
   # Scopes
   scope :editor_picks, lambda {
       where(editor_pick: false)
           .order("updated_at DESC")
   }
end
