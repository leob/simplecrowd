module ProjectsHelper
   def project_tab(tab_name)
      render partial: "projects/project_tab", locals: {tab_name: tab_name}
      #       locals: {control: control_type, f: f, column: column,
       #               options: form_options(wrapper_class, field_options, form_control_class)}
   end
end