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

  def friendly_name(user)
    if user == current_user
      return 'You'
    else
      return user.username
    end
  end

  def g_pushpin
    return "<span aria-hidden='true' class='glyphicon glyphicon-pushpin' title='This is a sticky topic'></span>".html_safe
  end

  def g_cert
    return "<span aria-hidden='true' class='glyphicon glyphicon-certificate' title='Only Admins can see and post to this forum'></span>".html_safe
  end

  def g_flag
    return "<span aria-hidden='true' class='glyphicon glyphicon-flag' title='Topics will be shown on main feed'></span>".html_safe
  end

  def g_lock
    return "<span aria-hidden='true' class='glyphicon glyphicon-lock' title='This has been locked preventing future comments'></span>".html_safe
  end

  def g_eye
    return "<span aria-hidden='true' class='glyphicon glyphicon-eye-close' title='This has been soft deleted. Only super admins can see this.'></span>".html_safe
  end

  def g_fire
    return "<span aria-hidden='true' class='glyphicon glyphicon-fire' title='This will remove this from the databasae! CAN NOT UNDO!'></span>".html_safe
  end

end
