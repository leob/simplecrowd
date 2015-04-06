class User < ActiveRecord::Base
   # Relations
   has_many :projects

   # Include default devise modules. Others available are:
   # :confirmable, :lockable, :timeoutable and :omniauthable
   devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :confirmable
   # TODO add these? :lockable, :timeoutable and :omniauthable

   # Pagination
   paginates_per 30

   # Validations

   # :email
   validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

   # SCOPE, ORDER, PAGING

   #
   # Instead of the Rails "scope" macro we just use class methods. Exactly the same functionality but more flexible.
   #

   def self.paged(page_number)
      order(admin: :desc, email: :asc).page page_number
   end

   def self.search_and_order(search, page_number)
      if search
         where("email LIKE ?", "%#{search.downcase}%").order(
             admin: :desc, email: :asc
         ).page page_number
      else
         order(admin: :desc, email: :asc).page page_number
      end
   end

   def self.last_signups(count)
      order(created_at: :desc).limit(count).select("id", "email", "created_at")
   end

   def self.last_signins(count)
      order(last_sign_in_at:
                :desc).limit(count).select("id", "email", "last_sign_in_at")
   end

   def self.users_count
      #where("admin = ? AND locked = ?", false, false).count
      count
   end
end
