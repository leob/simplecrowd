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

   def user_link(logged_in)
      css_class_primary = "text-primary navlink-justright"
      css_class_secondary = "navlink-small navlink-justleft"

      content_tag(:li) do
         if logged_in
            nav_link("my_4just1", nil, class: css_class_primary) +
                nav_link("sign_out", destroy_user_session_path, data: {method: :delete}, class: css_class_secondary)
         else
            nav_link("start_project", nil, class: css_class_primary) +
               nav_link("sign_in", new_user_session_path, class: css_class_secondary)
         end
      end
   end

private

   def nav_link(name, path, html_options = nil)
      link_to(t("link_" + name.downcase), path, html_options)
   end

end
