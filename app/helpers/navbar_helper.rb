module NavbarHelper

   def nav_link(name, path, html_options = nil)
      link_to(t("navbar." + name.downcase), path, html_options)
   end

end
