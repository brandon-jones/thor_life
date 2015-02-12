module ApplicationHelper

  def flash_msg(login=false)
    builder = ""
    flash.each do |key, value|
    	if login == true
    		builder += "<div class='flash #{key}' id='#{key}'>#{value}</div>"
      else
    		if key != 'login_error' 
      		builder += "<div class='flash #{key}' id='#{key}'>#{value}</div>"
      	end
      end
    end
    return builder.html_safe
  end

end
