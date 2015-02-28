module FormHelper
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
      render partial: 'layouts/form_messages', locals: {model: model_obj}
   end

   def form_title(form_name)
      title_key = "forms." + form_name.downcase + ".title"

      # set the page title equal to the form title
      page_title(title_key)

      content_tag(:h1) do
         t(title_key)
      end
   end

   def form_text_field(f, column, wrapper_class: form_wrapper_class, field_options: {})
      form_control "form_text_field", f, column, wrapper_class, field_options
   end

   def form_text_area(f, column, wrapper_class: form_wrapper_class, field_options: {})
      form_control "form_text_area", f, column, wrapper_class, field_options
   end

   def form_submit_button(f, wrapper_class: form_wrapper_class, field_options: {})
      render partial: "form_submit_button",
             locals: {f: f, options: form_options(wrapper_class, field_options, form_submit_button_class)}
   end

   # Renders a Bootstrap form group (label + input). The view can use a block to render the input field, e.g. like this:
   #
   # <%= form_group(f, :name) do %>
   #     <%= f.text_field :name, class: "form-control", :autofocus => true %>
   # <% end %>
   #
   # We are doing this by rendering the partial (form_group_layout.erb.html) as a layout containing a "yield" statement.
   #
   # This technique was inspired by:
   #
   # http://stackoverflow.com/questions/2951105/rails-render-partial-with-block
   # http://stackoverflow.com/questions/2951105/rails-render-partial-with-block/2952056#2952056
   #
   def form_group(f, column, wrapper_class: form_wrapper_class, &block)
      render layout: "form_group_layout", locals: {f: f, column: column, options: {wrapper_class: wrapper_class}}, &block
   end

   private

   def form_control(control_type, f, column, wrapper_class, field_options)
      render partial: "form_group",
             locals: {control: control_type, f: f, column: column,
                      options: form_options(wrapper_class, field_options, form_control_class)}
   end

   def form_options(wrapper_class, field_options, css_class)
      field_options[:class] = (field_options[:class].nil? ? "" : field_options[:class] + " ") + css_class

      {wrapper_class: wrapper_class, field_options: field_options}
   end

   def form_wrapper_class
      "col-sm-6"
   end

   def form_control_class
      "form-control"
   end

   def form_submit_button_class
      "btn btn-primary"
   end
end
