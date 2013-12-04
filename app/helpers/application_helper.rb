module ApplicationHelper
  def nav_link_to(name, path)
    options = {}
    options[:class] = "active" if controller.class.name.downcase.include?(name.downcase)

    link_to name, path, options
  end
end
