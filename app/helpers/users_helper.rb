module UsersHelper
  
  def isLoggedInUserAdmin?
    return false if session[:user] == nil 
    return session[:user].isAdmin
  end
  
end
