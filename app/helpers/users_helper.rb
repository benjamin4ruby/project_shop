module UsersHelper
  
  def isLoggedInUserAdmin?
    loggedInUser = User.find(session[:user_id])
    return loggedInUser.isAdmin
  end
  
end
