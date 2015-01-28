require "awesome_print"
AwesomePrint.pry!

Pry.config.editor = 'vim'

if defined? Rails
  Pry.config.prompt_name = Rails.application.class.parent_name.underscore.dasherize

  unless Rails.env.development?
    old_prompt = Pry.config.prompt

    env = if Rails.env.production?
      Pry::Helpers::Text.red(Rails.env.upcase)
    else
      Pry::Helpers::Text.yellow(Rails.env.upcase)
    end

    Pry.config.prompt = [
      proc { |*a| "#{env} #{old_prompt.first.call(*a)}"  },
      proc { |*a| "#{env} #{old_prompt.second.call(*a)}" }
    ]
  end
end
