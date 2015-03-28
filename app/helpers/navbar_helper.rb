module NavbarHelper

   #
   # Helper to generate a navbar nav option using a button (class 'btn'). The trick is to embed it inside a div, see:
   # http://stackoverflow.com/questions/9252712/twitter-bootstrap-what-is-the-correct-way-to-use-the-btn-class-within-a-navb
   #
   # TODO change this to use a partial? see:
   #
   # http://stackoverflow.com/questions/12309338/helpers-in-rails-whats-the-best-approach-when-building-the-html-string
   # http://stackoverflow.com/questions/3561250/using-helpers-in-rails-3-to-output-html
   #
   def nav(name, path, html_options = nil)
      content_tag(:li) do
         nav_link(name, path, html_options)
      end
   end

   CSS_CLASS_PRIMARY = "text-primary navlink-justright"
   CSS_CLASS_SECONDARY = "navlink-small navlink-justleft"

   def user_link(logged_in)

      content_tag(:li) do
         if logged_in
            nav_link("my_4just1", nil, class: CSS_CLASS_PRIMARY) +
               nav_link("sign_out", destroy_user_session_path, data: {method: :delete}, class: CSS_CLASS_SECONDARY)
         else
            nav_link("start_project", nil, class: CSS_CLASS_PRIMARY) +
               nav_link("sign_in", new_user_session_path, class: CSS_CLASS_SECONDARY)
         end
      end
   end

   def nav_link(name, path, html_options = nil)
      link_to(t("navbar." + name.downcase), path, html_options)
   end

end
