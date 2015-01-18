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
end
