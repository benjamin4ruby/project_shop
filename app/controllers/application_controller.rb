# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.


class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'd38174bcbfac1e3ba24ca9703452c0c8'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password

  # Internationalisation
  before_filter :set_locale, :set_guest_as_user
  
  def set_guest_as_user
    session[:user] = User.find(:first, :conditions => { :name => "Guest"})
  end
  
  def set_locale 
  	# if params[:locale] is nil then I18n.default_locale will be used
  	I18n.locale = params[:locale] 
  end 
  
  def default_url_options(options={})
  	{ :locale => I18n.locale }
  end 
end
