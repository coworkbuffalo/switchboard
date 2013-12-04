module ApplicationHelper
  def nav_link_to(name, path)
    options = {}
    options[:class] = "active" if controller.class.name.include?(name)

    link_to name, path, options
  end
end
