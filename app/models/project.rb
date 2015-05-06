class Project < ActiveRecord::Base
   belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id'
   belongs_to :category #, :class_name => 'Category', :foreign_key => 'category_id'

   # Pagination
   paginates_per 30

   validates :name, presence: true, length: {maximum: 50}
   validates :category, presence: true
   validates :summary, presence: true, length: {maximum: 250}
   validates :description, presence: true

   monetize :target_amount_cents, :collected_amount_cents

   has_attached_file :image,
                     :styles => {
                         :prethumb => ["223x162>", :jpg],
                         :thumb => ["140x140!", :jpg]
                     },
                     :convert_options => {
                         :all => "-quality 75 -strip"
                     }

   validates_attachment :image, #:presence => true,
                        :content_type => {content_type: ["image/jpeg", "image/gif", "image/png"],
                                          message: ': ' + I18n.t('forms.errors.invalid_file_type')},
                        :size => {in: 0..8.megabytes,
                                  message: ': ' + I18n.t('forms.errors.invalid_file_size', size_mb: 8)}

   validate :check_currencies

   def check_currencies
      if target_amount.currency != collected_amount.currency
         errors[:base] << I18n.t('forms.projects.errors.not_the_same_currency')
      end
   end

   after_validation :clean_paperclip_errors

   #
   # 'Randomize file name': technique taken from http://trevorturk.com/2009/03/22/randomize-filename-in-paperclip/
   #
   before_create :randomize_file_name
   # NOTE: also do this "before_update" ??

   def randomize_file_name
      if image_file_name
         extension = File.extname(image_file_name).downcase
         self.image.instance_write(:file_name, "#{SecureRandom.hex(16)}#{extension}")
      end
   end

   #
   # Clean the validation errors generated by Paperclip, see:
   #
   # http://stackoverflow.com/questions/19933579/ruby-on-rails-4-duplicate-paperclip-validation-messages
   #
   def clean_paperclip_errors
      errors.delete(:image_file_size)
      errors.delete(:image_content_type)
   end

   # VIRTUAL PROPERTIES (calculated fields)

   def days_to_go
      project_end_date = self.end_date || Time.now
      project_start_date = self.start_date || project_end_date

      [project_end_date.at_beginning_of_day - project_start_date.at_beginning_of_day, 0].max.to_i
   end

   def percentage
      return 0 if self.target_amount.cents <= 0

      ((self.collected_amount * 100) / self.target_amount).to_i
   end

   # SCOPE, ORDER, PAGING

   #
   # Instead of the Rails "scope" macro we generally just use class methods; same functionality but more flexible.
   #

   # DEFAULT SCOPE (for all queries outside of the admin namespace) - note that this IS a scope ...
   default_scope { where(draft: false, disabled: false) }

   def self.selected_projects(nr_projects = 12)
      where(editor_pick: true)
          .order(created_at: :desc)
          .limit(nr_projects)
   end

   def self.search_and_order(text, category, order_by)
      query = all

      if not text.blank?
         value = "%#{text.downcase}%"
         query = query.where("name LIKE ? OR summary like ?", value, value)
      end

      if not category.blank?
         query = query.where(:category => category)
      end

      query.order(created_at: :desc)
   end

   # ADMIN NAMESPACE ONLY SCOPES - CLEARING THE DEFAULT SCOPE

   def self.paged(page_number)
      self.unscoped do
         self.default_order.page page_number
      end
   end

   def self.search_paged(search, page_number)
      self.unscoped do
         if search
            where("name LIKE ?", "%#{search.downcase}%").default_order.page page_number
         else
            self.paged(page_number)
         end
      end
   end

   def self.default_order
      order(name: :asc)
   end

end
