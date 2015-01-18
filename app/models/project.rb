class Project < ActiveRecord::Base
   # Validations
   validates :name, presence: true
   validates :description, presence: true

   # Scopes
   scope :editor_picks, lambda {
                         where(editor_pick: false)
                             .order("updated_at DESC")
   }
end
