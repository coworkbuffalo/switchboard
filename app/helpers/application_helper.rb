module ApplicationHelper
  def nav_link_to(name, path)
    options = {}
    options[:class] = "active" if controller.class.name.downcase.include?(name.downcase)

    link_to name, path, options
  end

  def easternify(date, format)
    date.in_time_zone("Eastern Time (US & Canada)").to_formatted_s(format)
  end
end
