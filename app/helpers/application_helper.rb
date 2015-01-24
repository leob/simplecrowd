module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value}"
    end
  end

  #
  # A simple way to show error messages for the current controller/form resource.
  #
  # COPIED/MODIFIED FROM: devise_helper.rb
  #
  def devise_form_errors
    form_errors resource
    # return "" if resource.errors.empty?
    #
    # messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    #
    # html = <<-HTML
    # <div class="form-errors">
    #   <ul>#{messages}</ul>
    # </div>
    # HTML
    #
    # html.html_safe
  end

  # Show form errors by rendering the 'form_messages' partial.
  # We pass model_obj (the view's Active Model) to the partial.
  def form_errors(model_obj)
    render partial: 'layouts/form_messages', locals: { model: model_obj }
  end

  # def like_button(width = 70, show_faces = false)
  #   raw "<div class=\"fb-like\" data-send=\"false\" data-width=\"#{width}\" data-layout=\"box_count\" data-show-faces=\"true\"></div>"
  # end

  # def tweet_button
  #   tweet_text = "I'm #{Settings.primary_stat_verb} number #{number_with_delimiter Order.backers, :delimiter => ","} #{Settings.tweet_text}!"
  #   raw "<a href='https://twitter.com/share?url=/' id='tweet_button' class='twitter-share-button twitter-button' data-url=#{request.scheme}//#{request.host}' data-via='#{Settings.product_name}' data-lang='en' data-count='vertical' data-text=\"#{tweet_text}\">Tweet</a>"
  # end
end
