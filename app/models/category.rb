class Category < ActiveRecord::Base
   has_many :projects

   # SCOPE, ORDER, PAGING

   #
   # Instead of the Rails "scope" macro we just use class methods. Exactly the same functionality but more flexible.
   #

   def self.active_categories(locale)
      # use the correct category name (name_nl or name_en) depending on the current locale ('nl' or 'en')
      select("id, name_" + locale + " as name")
         .where(enabled: true)
         .order("name_" + locale)
   end

end
