module ApplicationHelper

  def flash_msg
    builder = ""
    flash.each do |key, value|
      builder += "<div class='flash #{key}' id='#{key}'>#{value}</div>"
    end
    return builder.html_safe
  end
end
