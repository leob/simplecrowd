module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value}"
    end
  end
end
