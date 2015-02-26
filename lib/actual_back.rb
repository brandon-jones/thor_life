# lib/money_attributes.rb
module ActualBack

	@@banned_paths = [ '/login',
									 	 '/logout']

 	def set_last_path path
  	unless @path == false || @@banned_paths.include?(path)
    	session[:_tl_last_path] = path
    end
  end

  def last_path
    return session[:_tl_last_path] || '/'
  end
end