module ApplicationHelper

   # def title(value)
   #   # the reason for the "#{value}" construct is to apply HTML-escaping
   #   @title = "#{value}" if value
   # end

   def page_title(key_or_value)
      @title = I18n.t(key_or_value, default: key_or_value) if key_or_value
   end

   def current_locale
      I18n.locale.to_s
   end

   # def user_signed_in?
   #   false
   # end

   # def like_button(width = 70, show_faces = false)
   #   raw "<div class=\"fb-like\" data-send=\"false\" data-width=\"#{width}\" data-layout=\"box_count\" data-show-faces=\"true\"></div>"
   # end

   # def tweet_button
   #   tweet_text = "I'm #{Settings.primary_stat_verb} number #{number_with_delimiter Order.backers, :delimiter => ","} #{Settings.tweet_text}!"
   #   raw "<a href='https://twitter.com/share?url=/' id='tweet_button' class='twitter-share-button twitter-button' data-url=#{request.scheme}//#{request.host}' data-via='#{Settings.product_name}' data-lang='en' data-count='vertical' data-text=\"#{tweet_text}\">Tweet</a>"
   # end
end
